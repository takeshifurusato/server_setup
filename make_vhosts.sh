#!/bin/sh

#-------------------------------------------------------------------------------------------------------------
# make documentroot directory
# /var/www/www.exsample.com/htdocs
# /var/www/www.exsample.com/logs
mkdir -p /var/www/${VHOST_FQDN}/{htdocs,logs}
chown -R ${OPE_USER_NAME}:apache /var/www/${VHOST_FQDN}/

#-------------------------------------------------------------------------------------------------------------
# make virtual host
cat << _EOT_ > /etc/httpd/conf.d/${VHOST_FQDN}.conf
<VirtualHost *:80>
    DocumentRoot /var/www/${VHOST_FQDN}/htdocs
    ServerName ${VHOST_FQDN}
    ErrorLog  /var/www/${VHOST_FQDN}/logs/error_log
    CustomLog  /var/www/${VHOST_FQDN}/logs/access_log combined env=!nolog
</VirtualHost>
_EOT_

echo ${VHOST_FQDN} > /var/www/${VHOST_FQDN}/htdocs/index.html

#-------------------------------------------------------------------------------------------------------------
# make database
mysql -uroot -p${PWD_MYSQL} << _EOT_
 CREATE DATABASE ${DB_NAME};
 CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
 GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
 FLUSH PRIVILEGES;
_EOT_

#-------------------------------------------------------------------------------------------------------------
# service httpd restart
service httpd restart


