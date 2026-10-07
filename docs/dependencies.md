# 依存ライブラリの管理（uv）

Pythonのライブラリは [uv](https://docs.astral.sh/uv/) で管理しています。

## ファイルの役割

| ファイル | 役割 | 手で編集する？ |
|---|---|---|
| `pyproject.toml` | 使いたいライブラリの一覧（直接使うものだけ） | する |
| `uv.lock` | 全ライブラリ（間接的に必要なものも含む）の版を固定したもの | しない（uvが生成） |
| `layer/requirements.txt` | Lambda Layer用。`uv.lock` から書き出したもの | しない（uvが生成） |

* 開発コンテナは `pyproject.toml` と `uv.lock` から環境を作ります（`.devcontainer/Dockerfile`）。
* Lambda Layerは `sam build` が `layer/requirements.txt` から作ります。
* 3つとも必ずコミットします。`uv.lock` と `layer/requirements.txt` が、ビルドのたびに版が変わらないことを保証します。

## よく使う操作

uvはローカル(Mac)に入っている前提です（`uv --version` で確認）。
**ライブラリを変更したら、必ず最後に「`layer/requirements.txt` の書き出し」までセットで実行します。**

### ライブラリを追加する
```sh
uv add <パッケージ名>
uv export --no-hashes --no-dev --no-emit-project -o layer/requirements.txt
```

### ライブラリを削除する
```sh
uv remove <パッケージ名>
uv export --no-hashes --no-dev --no-emit-project -o layer/requirements.txt
```

### 全ライブラリを最新にする
```sh
uv lock --upgrade
uv export --no-hashes --no-dev --no-emit-project -o layer/requirements.txt
```
更新後は、開発コンテナの再ビルドと動作確認をしてから、デプロイしてください。

### 特定のライブラリだけ最新にする
```sh
uv lock --upgrade-package <パッケージ名>
uv export --no-hashes --no-dev --no-emit-project -o layer/requirements.txt
```

### 開発用だけのツール（pytestなど）を入れる
Lambdaには入れず、開発コンテナにだけ入れたい場合は `--dev` を付けます。
```sh
uv add --dev <パッケージ名>
```
`layer/requirements.txt` の書き出しコマンドには `--no-dev` が付いているため、Lambdaには入りません。

## 開発コンテナの再ビルド
`pyproject.toml` / `uv.lock` を変更したら、開発コンテナを再ビルドして反映します。
VS Code の場合: コマンドパレット → `Dev Containers: Rebuild Container`

## バージョンの固定について
* Pythonのバージョン: `.devcontainer/Dockerfile` の `FROM python:3.13` と、`pyproject.toml` の `requires-python`。Lambdaのランタイム(`template.yaml`)とも揃えること。
* uvのバージョン: `.devcontainer/Dockerfile` の `COPY --from=ghcr.io/astral-sh/uv:<バージョン>`。ローカルのuvを上げたときは、こちらも合わせて更新する。
