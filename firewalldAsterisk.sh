#!/bin/bash

yum install firewalld -y
systemctl start firewalld
systemctl enable firewalld

firewall-cmd --permanent --zone=public --add-port=5060/tcp
firewall-cmd --permanent --zone=public --add-port=5060/udp
firewall-cmd --permanent --zone=public --add-port=5061/tcp
firewall-cmd --permanent --zone=public --add-port=5061/udp
firewall-cmd --permanent --zone=public --add-port=5160/tcp
firewall-cmd --permanent --zone=public --add-port=5160/udp
firewall-cmd --permanent --zone=public --add-port=4569/udp
firewall-cmd --permanent --zone=public --add-port=5038/tcp
firewall-cmd --permanent --zone=public --add-port=5038/udp
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --permanent --zone=public --add-port=10000-20000/udp
firewall-cmd --reload
