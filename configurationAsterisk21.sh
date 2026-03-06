#!/bin/bash

sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0
dnf install nano wget yum sox -y
curl -sL https://rpm.nodesource.com/setup_18.x | bash -
dnf install gcc-c++ make nodejs -y
wget https://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-21.9.1.tar.gz
tar zxvf asterisk-*.tar.gz
cd asterisk-21.9.1/
contrib/scripts/install_prereq install
contrib/scripts/get_mp3_source.sh
./configure --with-pjproject-bundled --with-jansson-bundled --with-crypto --with-ssl=ssl --with-srtp
make menuselect
make && make install && make config && make samples && ldconfig
useradd -m asterisk
sed -i 's/ASTARGS=""/ASTARGS="-U asterisk"/g' /usr/sbin/safe_asterisk
chown asterisk:asterisk /var/run/asterisk
chown -R asterisk:asterisk /etc/asterisk
chown -R asterisk:asterisk /var/{lib,log,spool}/asterisk
chown -R asterisk:asterisk /usr/lib/asterisk
