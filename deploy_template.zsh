#!/bin/zsh

echo "環境変数を指定してください"

# 秘密値は入力を画面に表示しない
while [[ -z "$ApiKey" ]]; do
    read -s -r "?OPENAI_API_KEY: " ApiKey; echo
done

while [[ -z "$ChannelId" ]]; do
    vared -p "SLACK_CHANNEL_ID": -c ChannelId
done

while [[ -z "$SigningSecretChatGPT" ]]; do
    read -s -r "?SLACK_API_SIGNING_SECRET_CHATGPT: " SigningSecretChatGPT; echo
done

while [[ -z "$OAuthTokenChatGPT" ]]; do
    read -s -r "?SLACK_BOT_OAUTH_TOKEN_CHATGPT: " OAuthTokenChatGPT; echo
done

while [[ -z "$SigningSecretClaude" ]]; do
    read -s -r "?SLACK_API_SIGNING_SECRET_CLAUDE: " SigningSecretClaude; echo
done

while [[ -z "$OAuthTokenClaude" ]]; do
    read -s -r "?SLACK_BOT_OAUTH_TOKEN_CLAUDE: " OAuthTokenClaude; echo
done

# 末尾4文字だけ表示する（4文字以下なら全て伏せる）
mask() {
    if (( ${#1} > 4 )); then
        echo "********${1[-4,-1]}"
    else
        echo "********"
    fi
}

echo "=== deploy info ==="
echo " "
echo "ApiKey: $(mask $ApiKey)"
echo "ChannelId: $ChannelId"
echo "SigningSecretChatGPT: $(mask $SigningSecretChatGPT)"
echo "OAuthTokenChatGPT: $(mask $OAuthTokenChatGPT)"
echo "SigningSecretClaude: $(mask $SigningSecretClaude)"
echo "OAuthTokenClaude: $(mask $OAuthTokenClaude)"
echo "==================="
echo " "

yn=""
vared -p "デプロイを開始しますがよろしいですか？(y/n): " yn
case "$yn" in [yY]*) ;; *) echo "abord." ; exit ;; esac

sam build && sam deploy \
    --stack-name slackbot \
    --region ap-northeast-1 \
    --parameter-overrides ApiKey=${ApiKey} ChannelId=${ChannelId} \
    SigningSecretChatGPT=${SigningSecretChatGPT} OAuthTokenChatGPT=${OAuthTokenChatGPT} \
    SigningSecretClaude=${SigningSecretClaude} OAuthTokenClaude=${OAuthTokenClaude}
