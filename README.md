# 構築内容
```
Centos7
PHP v8
phpMyAdmin
MySQL v8
Composer
Node.js v16
gulp
```

# DockerでCentOSを使ったLAMP環境構築

コマンド ビルドして起動 
```
$ docker-compose up -d
```
<br>

アクセス方法 *ポート番号はdocker-compose.ymlに設定されているポート番号
```
  http://localhost:ポート番号/
```
<br>

コンテナに入る サービス名はDockerfileで記載してある「centos」
```
  docker-compose exec サービス名 bash
```
<br>

## ポートの追加方法
### 例:92番ポートを通す方法
<br>

centos7/copy/v_host.confに以下を追加

```
<VirtualHost *:92>
DocumentRoot /var/www/html/site92 #ポートを通すパスを指定
ServerName localhost92
</VirtualHost>
```
<br>

centos7/copy/httpd.confに以下を追加
の編集
```
Listen 92
```
<br>

centos7/docker-compose.ymlに以下を追加
```
ports:
- 8092:92
```

<br>

コマンド 再度ビルドして起動
```
$ docker-compose up --build -d
```

<br>

## MySQLのパスワード変更

初期パスワード確認
```
$ cat /var/log/mysqld.log | grep password
```

<br>

パスワードポリシー変更
```
$ set global validate_password_length=4;
$ set global validate_password_mixed_case_count=0;
$ set global validate_password_number_count=0;
$ set global validate_password_policy=LOW;
```

<br>

パスワード変更
```
$ SET PASSWORD FOR root@localhost=password('パスワード');
```
