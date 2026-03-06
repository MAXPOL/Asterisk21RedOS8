#!/bin/bash

systemctl stop httpd php-fpm
fwconsole stop 2>/dev/null
sleep 2
rm -rf /var/lib/php/session/*
rm -rf /var/lib/php/wsdlcache/* 2>/dev/null
mkdir -p /var/lib/php/session
mkdir -p /var/lib/php/wsdlcache
chown -R asterisk:asterisk /var/lib/php/session
chown -R asterisk:asterisk /var/lib/php/wsdlcache
chmod 755 /var/lib/php/session
chmod 755 /var/lib/php/wsdlcache
chattr -i /etc/asterisk/* 2>/dev/null
chown -R asterisk:asterisk /etc/asterisk
chmod -R 775 /etc/asterisk
chown -R asterisk:asterisk /var/www/html/
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;
usermod -a -G asterisk apache
usermod -a -G apache asterisk
sed -i 's/^user =.*/user = asterisk/' /etc/php-fpm.d/www.conf
sed -i 's/^group =.*/group = asterisk/' /etc/php-fpm.d/www.conf
grep -q "session.save_path" /etc/php-fpm.d/www.conf || echo "php_value[session.save_path] = /var/lib/php/session" >> /etc/php-fpm.d/www.conf
sed -i 's/AllowOverride None/AllowOverride All/g' /etc/httpd/conf/httpd.conf
systemctl start php-fpm
systemctl start httpd
fwconsole start 2>/dev/null
systemctl status php-fpm --no-pager | grep "Active"
systemctl status httpd --no-pager | grep "Active"
fwconsole status 2>/dev/null | head -3
ls -la /var/lib/php/session/ | head -5
