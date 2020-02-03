# ファイナンシャルプランナー予約サービス

#### 環境
- Ruby 2.6.5
- Node.js 12.14.0
- Rails 5.2.4.1
- MySQL Ver 14.14 Distrib 5.7.28

- MacOS 10.15.2 で動作確認済

## 準備
- nodeのインストール
    - なんらかのバージョン管理システム(nodenv等)を使うことをお勧めします
    - nodenvの場合
        - 12.14.0のインストール
            - `$ nodenv install 12.14.0`
            - `$ nodenv rehash`
            - 12.14.0がない場合, nodenv, node-buildのアップデートを試みてください
- rubyのインストール
    - なんらかのバージョン管理システム(rbenv等)を使うことをお勧めします
    - rbenvの場合
        - 2.6.5のインストール
            - `$ rbenv install 12.14.0`
            - `$ rbenv rehash`
            - 12.14.0がない場合, rbenv, ruby-buildのアップデートを試みてください
- bundlerのインストール
    - gem管理にbundlerを用います
    - `$ gem install bundler`でインストールできます（実行時のrubyのバージョンが2.6.5であることを確認してください）
- yarnのインストール
    - nodeパッケージの管理にyarnを用います, homebrewからインストールできます
    - `$ brew install yarn`

## setup
- リポジトリをクローン
    - `$ git clone git@github.com:AK-10/FPConsul.git`
- プロジェクトに移動
    - `cd FPConsul`

- gemのインストール
    - `$ bundle install --path vendor/bundle`
        - mysql2のインストールに失敗する場合あります
            - `LDFLAGS`をbundlerの環境変数として加える必要があります.(エラー内容に寄りますが)
            - `$ bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib"`

- nodeパッケージのインストール
    - $`yarn` で終わりです

- databaseの設定
    - `config/database.yml.sample`をもとに，dbに接続するための設定を行ってください
        - username, passwordを正しく変更すると動作します
    - `bundle exec rails db:create`でdbの作成
    - `bundle exec rails db:migrate`でマイグレーションの実行

- 完了
