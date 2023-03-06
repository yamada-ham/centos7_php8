FROM centos:7

RUN yum update -y && \
    yum install -y httpd

# Apache自動起動
RUN systemctl enable httpd.service

# PHP  
RUN yum install -y epel-release
RUN yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm

# yum-utils パッケージをインストールすると yum-config-manager コマンドが使えるようになる。
RUN yum -y install yum-utils && \ 
    yum-config-manager --enable remi

#php8
RUN yum -y install --enablerepo=remi,epel,remi-php80 php php-mysqlnd php-mbstring php-gd php-xml php-xmlrpc php-pecl-mcrypt php-fpm php-opcache php-apcu php-pear php-pdo php-zip php-unzip php-pecl-zip phpMyAdmin

# MySQL 5.7 > 8.0
# RUN yum -y install http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm && \
RUN yum -y install https://dev.mysql.com/get/mysql80-community-release-el7-5.noarch.rpm && \
    yum -y install mysql-community-server

# MySQL 自動起動
RUN systemctl enable mysqld

# RUN yum -y install mod_ssl && \
# yum -y install firewalld && \
# yum -y install certbot python2-certbot-apache

# composer 導入
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# composer バージョン変更
# RUN composer self-update 1.8.3

# Git
# RUN yum -y install git

# node.js 導入
RUN curl -fsSL https://rpm.nodesource.com/setup_16.x | bash -
# RUN yum install -y https://rpm.nodesource.com/pub_16.x/el/9/x86_64/nodesource-release-el9-1.noarch.rpm

# lsof は、サーバーで特定のポート番号を待ち受けているかどうか、指定ファイルは誰が読み込んでいるのかを調べる
RUN yum install -y nodejs vim lsof

# グローバル にgulpを導入
RUN npm install -g gulp

# 言語設定 UTF-8を使えるようにする
ENV LC_ALL en_US.UTF-8

# ホストで用意した設定ファイルを反映
# COPY ./copy/httpd.conf /etc/httpd/conf/httpd.conf
# COPY ./copy/v_host.conf /etc/httpd/conf.d/v_host.conf
# COPY ./copy/php.ini /etc/php.ini
# COPY ./copy/phpMyAdmin.conf /etc/httpd/conf.d/phpMyAdmin.conf

# MySQLの設定
# COPY ./copy/my.cnf /etc/my.cnf

# ディレクトリの所有者、グループを変更する。
# RUN chown apache:apache /var/www/html/php_error.log


#公開ポート番号
EXPOSE 80