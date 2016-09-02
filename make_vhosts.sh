#!/bin/sh

#-------------------------------------------------------------------------------------------------------------
# make documentroot directory
# /var/www/www.exsample.com/htdocs
# /var/www/www.exsample.com/logs
sudo mkdir -p /var/www/${VHOST_FQDN}/{htdocs,logs}
sudo chown -R ${OPE_USER_NAME}:apache /var/www/${VHOST_FQDN}/

#-------------------------------------------------------------------------------------------------------------
# make virtual host
cat << _EOT_ | sudo tee /etc/httpd/conf.d/aaaaaa.conf
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
sudo mysql -uroot -p${PWD_MYSQL} << _EOT_
 CREATE DATABASE ${DB_NAME};
 CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
 GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
 FLUSH PRIVILEGES;
_EOT_

#-------------------------------------------------------------------------------------------------------------
# service httpd restart
sudo service httpd restart


