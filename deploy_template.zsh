#!/bin/zsh

echo "環境変数を指定してください"

while [[ -z "$ApiKey" ]]; do
    vared -p "OPENAI_API_KEY": -c ApiKey
done

while [[ -z "$ChannelId" ]]; do
    vared -p "SLACK_CHANNEL_ID": -c ChannelId
done

while [[ -z "$SigningSecretGPT3" ]]; do
    vared -p "SLACK_API_SIGNING_SECRET_GPT3": -c SigningSecretGPT3
done

while [[ -z "$OAuthTokenGPT3" ]]; do
    vared -p "SLACK_BOT_OAUTH_TOKEN_GPT3": -c OAuthTokenGPT3
done

while [[ -z "$SigningSecretGPT4" ]]; do
    vared -p "SLACK_API_SIGNING_SECRET_GPT4": -c SigningSecretGPT4
done

while [[ -z "$OAuthTokenGPT4" ]]; do
    vared -p "SLACK_BOT_OAUTH_TOKEN_GPT4": -c OAuthTokenGPT4
done

while [[ -z "$SigningSecretClaude1" ]]; do
    vared -p "SLACK_API_SIGNING_SECRET_CLAUDE1": -c SigningSecretClaude1
done

while [[ -z "$OAuthTokenClaude1" ]]; do
    vared -p "SLACK_BOT_OAUTH_TOKEN_CLAUDE1": -c OAuthTokenClaude1
done

while [[ -z "$SigningSecretClaude2" ]]; do
    vared -p "SLACK_API_SIGNING_SECRET_CLAUDE2": -c SigningSecretClaude2
done

while [[ -z "$OAuthTokenClaude2" ]]; do
    vared -p "SLACK_BOT_OAUTH_TOKEN_CLAUDE2": -c OAuthTokenClaude2
done

echo "=== deploy info ==="
echo " "
echo "ApiKey: $ApiKey"
echo "ChannelId: $ChannelId"
echo "SigningSecretGPT3: $SigningSecretGPT3"
echo "OAuthTokenGPT3: $OAuthTokenGPT3"
echo "SigningSecretGPT4: $SigningSecretGPT4"
echo "OAuthTokenGPT4: $OAuthTokenGPT4"
echo "SigningSecretClaude1: $SigningSecretClaude1"
echo "OAuthTokenClaude1: $OAuthTokenClaude1"
echo "SigningSecretClaude2: $SigningSecretClaude2"
echo "OAuthTokenClaude2: $OAuthTokenClaude2"
echo "==================="
echo " "

yn=""
vared -p "デプロイを開始しますがよろしいですか？(y/n): " yn
case "$yn" in [yY]*) ;; *) echo "abord." ; exit ;; esac

sam build && sam deploy \
    --stack-name slackbot \
    --region ap-northeast-1 \
    --parameter-overrides ApiKey=${ApiKey} ChannelId=${ChannelId} \
    SigningSecretGPT3=${SigningSecretGPT3} OAuthTokenGPT3=${OAuthTokenGPT3} \
    SigningSecretGPT4=${SigningSecretGPT4} OAuthTokenGPT4=${OAuthTokenGPT4} \
    SigningSecretClaude1=${SigningSecretClaude1} OAuthTokenClaude1=${OAuthTokenClaude1} \
    SigningSecretClaude2=${SigningSecretClaude2} OAuthTokenClaude2=${OAuthTokenClaude2}
