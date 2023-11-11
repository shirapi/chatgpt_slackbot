## ChatGPTを搭載したSlackbot
* TODO
    * CodePipelineを構築し、mainブランチにpushでデプロイする
    * Amazon Bedrockを利用してみる(モデルはclaude2など)
    * FunctionsURLからAPI Gatewayに変更

### 仕様
* Botを使用できるのは特定のオープンチャンネルに限定する。
* 質問はBotにメンションして開始し、Botは発言したユーザーにメンションしてスレッドで返信を行う。  
チャンネルに投稿しただけ、またはスレッドに返信しただけなど、メンションしない限りBotは反応しない。  
（Botが反応するとチャンネル内、スレッド内でユーザー同士のやり取りがしづらいため）
* 応答するのに時間がかかるので、処理中であることを示すためにBotは発言に対して先にリアクションをつける。
* スレッドの内容に関してはBotは記憶がある状態で話ができる。

### 構成
* Lambda + Lambda FunctionsURL + Slack Bolt(python) + ChatGPT + LangChain(python)
    * Lambdaランタイム: Python 3.10
    * OpenAIなどのライブラリはlayerとして実装
    * SlackのSecretなどは環境変数で管理
    * CodePipeline + AWS SAMでデプロイする

![構成図](https://github.com/shirapi/chatgpt_slackbot/assets/55041839/147e5ef9-cf03-4276-95d5-27217b90e67c)

#### 開発時 OpenAI APK Keyの設定
```sh
cd .devcontainer
cp .variables.env.txt .variables.env
# 開いて MyOpenAPIKey を自分のapi keyに変更
```

#### 注意事項
* Lambdaのタイムアウトは3分程度は必要、動作しない場合はメモリを256MB以上とする
