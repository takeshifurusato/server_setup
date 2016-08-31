#!/bin/sh

#-------------------------------------------------------------------------------------------------------------
# parameters
export OPE_USER_NAME='username'
export PWD_MYSQL='mysqlpass'
export HOSTFQDN='hostfqdn'
export HOSTDOMAIN='hostdomain'

export DB_NAME='dbname'
export DB_USER='dbuser'
export DB_PASS='dbpass'

#-------------------------------------------------------------------------------------------------------------
# make documentroot directory
# /var/www/www.exsample.com/htdocs
# /var/www/www.exsample.com/logs
mkdir /var/www/${HOSTFQDN}/
mkdir /var/www/${HOSTFQDN}/htdocs
mkdir /var/www/${HOSTFQDN}/logs
chown -R ${OPE_USER_NAME}:apache /var/www/${HOSTFQDN}/

#-------------------------------------------------------------------------------------------------------------
# make virtual host
cat << _EOT_ > /etc/httpd/conf.d/${HOSTFQDN}.conf
<VirtualHost *:80>
    ServerAdmin webmaster@${HOSTDOMAIN}
    DocumentRoot /var/www/${HOSTFQDN}/htdocs
    ServerName ${HOSTFQDN}
    ErrorLog  /var/www/${HOSTFQDN}/logs/error_log
    CustomLog  /var/www/${HOSTFQDN}/logs/access_log combined env=!nolog
    <Directory  /var/www/${HOSTFQDN}/htdocs>
        Options Includes ExecCGI FollowSymLinks
        AllowOverride ALL
        Order allow,deny
        Allow from all
    </Directory>
</VirtualHost>
_EOT_

echo ${HOSTFQDN} > /var/www/${HOSTFQDN}/htdocs/index.html

#-------------------------------------------------------------------------------------------------------------
# make database
mysql -uroot -p${PWD_MYSQL} << _EOT_
 CREATE DATABASE ${DB_NAME};
 CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
 GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
 FLUSH PRIVILEGES;
_EOT_

#-------------------------------------------------------------------------------------------------------------
# service httpd graceful
service httpd graceful


