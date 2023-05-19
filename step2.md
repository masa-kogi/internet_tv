# テーブルの構築、データのインポート

手順として次のようにデータベース初期化を行います。
1. データベースの構築
2. テーブルの構築
3. サンプルデータのインポート

今回環境構築にはdockerを使用しており、コンテナを立ち上げると、上記の手順が自動的に実行されるようにしています。
ターミナル上で次のコマンドを実行してください。

```
git clone https://github.com/masa-kogi/internet_tv.git
cd internet_tv
docker compose build
docker compose up -d
```


コンテナが立ち上がったら、次のコマンドを実行してMySQLに接続します。
```
docker compose exec db mysql -u root -p
```

パスワードの入力が求められます。今回パスワードは"pass"としています。
MySQLに接続後、次のコマンドを実行してDBを指定します。

```
use internet_tv;
```
テーブルを確認すると、サンプルデータが格納されていることが確認できると思います。

## データベース初期化について

dockerのMySQLイメージでは、コンテナ内の/docker-entrypoint-initdb.dというディレクトリに、拡張子が.sh、.sql、.sql.gz、.sql.gzのDB初期化用のファイルを配置すると、コンテナを起動した時に実行してくれます。実行順序はファイル名によるため、ファイル名に数字でプレフィックスをつけるなどして実行してほしい順序が担保されるようにする必要があります。ここでは/docker-entrypoint-initdb.dに次のファイルを配置しています。

- [01_create_database.sql](./docker/db/init/01_create_database.sql)
- [02_create_table.sql](./docker/db/init/02_create_table.sql)
- [03_load_data_infile.sql](./docker/db/init/03_load_data_infile.sql)


なお、[03_load_data_infile.sql](./docker/db/init/03_load_data_infile.sql)で、コンテナにマウントしたサンプルデータファイルからデータをインポートしていますが、使用したイメージでは、ファイルの読み取り、書き込みを行うことができるディレクトリは、デフォルトでは/var/lib/mysql-files/とされています。そのためサンプルデータファイルを置くのは、このディレクトリ配下とするか、他のディレクトリに変更する場合には、設定ファイルなどでsecure-file-priv変数の値にディレクトリのパスを指定する必要があります。ここでは、secure-file-privの値は変更せず、docker-compose.ymlで、サンプルデータを/var/lib/mysql-files/dataにマウントしています。

因みに、番組枠のサンプルデータは、2023年5月の1ヶ月分です。便宜上、現時点で放送開始時間が到来していない番組枠にも視聴数データを入れています。
