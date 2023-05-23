## ChatGPTでSlackBot
暫定なので自動化などは未対応。
SAMなどでデプロイできるようにする予定。

### 構成と要件
* Lambda + Lambda FunctionsURL + Slack Bolt(python) + ChatGPT + LangChain(python)
* Botにメンションして発言すると応答してくれる
* 応答するのに時間がかかるので、Botは発言に対して先にリアクションをつける
* スレッドの内容は記憶がある状態で話ができる

#### 注意事項
* Lambdaのタイムアウトは3分程度は必要、メモリが128MBの場合動作しなかったので256MB以上とする

### OpenAI APK Keyの設定
```sh
cd .devcontainer
cp .variables.env.txt .variables.env
# 開いて MyOpenAPIKey を自分のapi keyに変更
```

### AWS Lambda
* OpenAIなどのライブラリはlayerとして登録する
* LambdaはコンソールからPythonで登録し、FunctionsURLを発行。
* 環境変数は手動で登録

1. コンテナ起動後、必要なライブラリをzipにする。
```sh
# pwd -> workspace
cd layer
./build_layer.sh
```
2. 作成されたzipをLambdaのレイヤーとして登録
3. 登録済みのLambdaFunctionに対して2のレイヤーを追加

