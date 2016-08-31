#!/bin/sh

#-------------------------------------------------------------------------------------------------------------
# parameters
export OPE_USER_NAME='opeuser'
export HOSTFQDN='wordpress.kensho.mobi'
export HOSTDOMAIN='wordpress.kensho.mobi'


#-------------------------------------------------------------------------------------------------------------
echo "make documentroot directory"
# /var/www/www.exsample.com/htdocs
# /var/www/www.exsample.com/logs
mkdir /var/www/${HOSTFQDN}/
mkdir /var/www/${HOSTFQDN}/htdocs
mkdir /var/www/${HOSTFQDN}/logs
chown -R ${OPE_USER_NAME}:apache /var/www/${HOSTFQDN}/

#-------------------------------------------------------------------------------------------------------------
echo "make virtual host"
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
echo "service httpd graceful"
service httpd graceful


