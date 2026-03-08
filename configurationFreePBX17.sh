#!/bin/bash

sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0

dnf install php82-release -y
dnf clean all && dnf makecache 
dnf install wget php php-mysqlnd php-pear php-cgi php-common php-curl php-mbstring php-gd php-gettext php-bcmath php-zip php-xml php-imap php-json php-process php-snmp -y
dnf install httpd nano wget yum sox -y
dnf install mariadb mariadb-server --allowerasing -y

curl -sL https://rpm.nodesource.com/setup_18.x | bash -
dnf install gcc-c++ make nodejs -y

systemctl start mariadb && systemctl enable mariadb
mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('1');"

systemctl start httpd && systemctl enable httpd 

wget http://mirror.freepbx.org/modules/packages/freepbx/freepbx-17.0-latest.tgz
tar xvfz freepbx-*.tgz
cd freepbx
./start_asterisk start
./install -n # ./install -n --dbuser root --dbpass 1 --webroot=/var/www/html

fwconsole ma downloadinstall pm2
fwconsole ma downloadinstall cdr
fwconsole ma downloadinstall logfiles
fwconsole ma downloadinstall filestore
fwconsole ma downloadinstall recordings
fwconsole ma enable pm2
fwconsole ma enable cdr
fwconsole ma enable logfiles
fwconsole ma enable filestore
fwconsole ma enable recordings
fwconsole ma install core
fwconsole ma upgradeall
systemctl stop httpd php-fpm
fwconsole stop 2>/dev/null

rm -rf /var/lib/php/session/* /var/lib/php/wsdlcache/* 2>/dev/null
mkdir -p /var/lib/php/session /var/lib/php/wsdlcache
chown -R asterisk:asterisk /var/lib/php/session /var/lib/php/wsdlcache
chmod 755 /var/lib/php/session /var/lib/php/wsdlcache
chattr -i /etc/asterisk/* 2>/dev/null
chown -R asterisk:asterisk /etc/asterisk
chmod -R 775 /etc/asterisk
chown asterisk:asterisk /etc/freepbx.conf 2>/dev/null
chmod 644 /etc/freepbx.conf 2>/dev/null
chown -R asterisk:asterisk /var/www/html/
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;
sed -i 's/^user =.*/user = asterisk/' /etc/php-fpm.d/www.conf
sed -i 's/^group =.*/group = asterisk/' /etc/php-fpm.d/www.conf
grep -q "session.save_path" /etc/php-fpm.d/www.conf || echo "php_value[session.save_path] = /var/lib/php/session" >> /etc/php-fpm.d/www.conf
sed -i 's/AllowOverride None/AllowOverride All/g' /etc/httpd/conf/httpd.conf
chown -R asterisk:asterisk /var/spool/asterisk /var/log/asterisk
usermod -a -G asterisk apache
systemctl start php-fpm httpd
fwconsole start 2>/dev/null
