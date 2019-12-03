# jackAPI

## 環境
- ruby 2.5.0
- Rails 6.0.1

## 環境構築

必要なソフトウェアを準備する．
- docker
- docker-compose

仮想環境の構築をdockerで行う．
```
$docker-compose up -d
$docker-compose exec web bash
```
仮想環境にログインできたら，次のコマンドで仮想環境にgemのインストールとデータベースの作成を行う
```
#bundle install --path vendor/bundle
#rails db:create
```
次のコマンドでサーバーを立てる．
```
#rails server -b 0.0.0.0
```
サーバーを立てた状態で`localhost:3000`にアクセスできたら成功．