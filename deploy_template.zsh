#!/bin/zsh

echo "環境変数を指定してください"
while [[ -z "$SigningSecret" ]]; do
    vared -p "SLACK_API_SIGNING_SECRET": -c SigningSecret
done

while [[ -z "$OAuthToken" ]]; do
    vared -p "SLACK_BOT_OAUTH_TOKEN": -c OAuthToken
done

while [[ -z "$ApiKey" ]]; do
    vared -p "OPENAI_API_KEY": -c ApiKey
done

while [[ -z "$ChannelId" ]]; do
    vared -p "SLACK_CHANNEL_ID": -c ChannelId
done

echo "=== deploy info ==="
echo " "
echo "SigningSecret: $SigningSecret"
echo "OAuthToken: $OAuthToken"
echo "ApiKey: $ApiKey"
echo "ChannelId: $ChannelId"
echo "==================="
echo " "

yn=""
vared -p "デプロイを開始しますがよろしいですか？(y/n): " yn
case "$yn" in [yY]*) ;; *) echo "abord." ; exit ;; esac

sam build && sam deploy \
    --stack-name slackbot \
    --region ap-northeast-1 \
    --parameter-overrides SigningSecret=${SigningSecret} OAuthToken=${OAuthToken} ApiKey=${ApiKey} ChannelId=${ChannelId}
