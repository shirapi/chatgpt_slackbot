## ChatGPTでSlackBot
* TODO
    * CodePipelineを構築し、mainブランチにpushでデプロイする
    * Amazon Bedrockを利用してみる(モデルはclaude2など)
    * FunctionsURLからAPI Gatewayに変更

### 構成と要件
* Lambda + Lambda FunctionsURL + Slack Bolt(python) + ChatGPT + LangChain(python)
    * Lambdaのランタイムは Python 3.10
    * OpenAIなどのライブラリはlayerとする
    * SlackのSecretなどは環境変数で管理
    * deployはCodePipeline + AWS SAMで実行する
* Botにメンションして発言すると応答してくれる
* 応答するのに時間がかかるので、Botは発言に対して先にリアクションをつける
* スレッドの内容は記憶がある状態で話ができる

#### 開発時 OpenAI APK Keyの設定
```sh
cd .devcontainer
cp .variables.env.txt .variables.env
# 開いて MyOpenAPIKey を自分のapi keyに変更
```

#### 注意事項
* Lambdaのタイムアウトは3分程度は必要、動作しない場合はメモリを256MB以上とする

### デプロイ
```sh
./deploy_template.sh
```