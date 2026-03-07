#!/bin/bash

iptables -P INPUT DROP
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp --dport 5060 -j ACCEPT
iptables -I INPUT -p udp --dport 5060 -j ACCEPT
iptables -I INPUT -p tcp --dport 5061 -j ACCEPT
iptables -I INPUT -p udp --dport 5061 -j ACCEPT
iptables -I INPUT -p tcp --dport 5160 -j ACCEPT
iptables -I INPUT -p udp --dport 5160 -j ACCEPT
iptables -I INPUT -p udp --dport 4569 -j ACCEPT
iptables -I INPUT -p tcp --dport 5038 -j ACCEPT
iptables -I INPUT -p udp --dport 5038 -j ACCEPT
iptables -I INPUT -p udp --dport 10000:20000 -j ACCEPT
