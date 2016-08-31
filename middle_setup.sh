#!/bin/sh

#-------------------------------------------------------------------------------------------------------------
# yum Package UPDATE
yum -y update
yum -y install expect sudo openssh-clients

# yum auto update 
yum -y install yum-cron
chkconfig yum-cron on

#-------------------------------------------------------------------------------------------------------------
### apache install & settings
yum -y install httpd httpd-devel mod_ssl

# Security log option
sed -i.orig /etc/httpd/conf/httpd.conf \
 -e '/^ServerTokens /s/ .*/ Prod/' \
 -e '/^DirectoryIndex /s/ .*/ index.php index.cgi index.html/' \
 -e '/^ServerSignature /s/ .*/ Off/' \
 -e '/^#AddHandler cgi-script /s/^#//' \
 -e '/^#NameVirtualHost *:80 /s/^#//' \
 -e '/<Directory \"\/var\/www\/html\">/,/<\/Directory>/s/AllowOverride None/AllowOverride ALL/' 

cat << '_EOT_' > /etc/httpd/conf.d/option.conf
# Security log option
SetEnvIf Request_Method "(GET)|(POST)|(PUT)|(DELETE)|(HEAD)" log
SetEnvIf Request_URI "^/default.ida" worm nolog
SetEnvIf Request_URI "null\.ida" worm nolog
SetEnvIf Request_URI "root\.exe" worm nolog
SetEnvIf Request_URI "cmd\.exe" worm nolog
SetEnvIf Request_URI "Admin\.dll" worm nolog
SetEnvIf Request_URI "^/_mem_bin/" worm nolog
SetEnvIf Request_URI "^/_vti_bin/" worm nolog
SetEnvIf Request_URI "^/c/" worm nolog
SetEnvIf Request_URI "^/d/" worm nolog
SetEnvIf Request_URI "^/msadc/" worm nolog
SetEnvIf Request_URI "^/scripts/" worm nolog
SetEnvIf Request_URI "\.(gif)|(jpg)|(png)|(ico)|(css)$" nolog
SetEnvIf Remote_Addr "127\.0\.0\.1" nolog
_EOT_

# POODLE SSLv3 CVE-2014-3566
sed -i /etc/httpd/conf.d/ssl.conf -e '/SSLProtocol/s/all .*/all -SSLv2 -SSLv3/'

# Log Rotation
cat << '_EOT_' > /etc/logrotate.d/httpd
/var/log/httpd/*log /home/*/logs/*log {
    monthly
    rotate 6
    missingok
    notifempty
    sharedscripts
    postrotate
        /sbin/service httpd reload > /dev/null 2>/dev/null || true
    endscript
}
_EOT_

# service start
chkconfig httpd on
service httpd start

#-------------------------------------------------------------------------------------------------------------
### PHP instarll & settings
yum -y install php php-devel php-mbstring gd gd-devel php-gd ImageMagick*
sed -i '/date.timezone =/s/^\;//;/date.timezone =/s/=.*/= Asia\/Tokyo/' /etc/php.ini


#-------------------------------------------------------------------------------------------------------------
### mysql insatall & settings
yum -y install mysql mysql-server php-mysql 

# my.cnf setting
cp -a /etc/my.cnf{,.orig}
cat << '_EOT_' > /etc/my.cnf
[mysqld]
character-set-server=utf8
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
user=mysql
symbolic-links=0
#old_passwords=1
log-bin
binlog-format=mixed
expire_logs_days=31
server-id=1
#skip-character-set-client-handshake
#max_connections=8000
#wait_timeout=28800
#thread_cache_size=400
#query_cache_size=16M

[mysqld_safe]
character-set-server=utf8
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid

[mysql]
default-character-set=utf8
_EOT_

service mysqld start
mysql -uroot << '_EOT_'
 DELETE FROM mysql.user WHERE User='';
 DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
 DROP DATABASE test;
 DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
 FLUSH PRIVILEGES;
_EOT_

# mysql settings
chkconfig mysqld on
service mysqld start

#set password
/usr/bin/mysqladmin -uroot password "${PWD_MYSQL}"

