#!/bin/bash

dnf -y install fail2ban

echo "[asterisk-iptables]" >> /etc/fail2ban/jail.conf
echo "enabled  = true" >> /etc/fail2ban/jail.conf
echo "filter   = asterisk" >> /etc/fail2ban/jail.conf
echo "action   = iptables-allports[name=ASTERISK, protocol=all]" >> /etc/fail2ban/jail.conf
echo "           sendmail-whois[name=ASTERISK, dest=root, sender=fail2ban@asterisk]" >> /etc/fail2ban/jail.conf
echo "logpath  = /var/log/asterisk/messages" >> /etc/fail2ban/jail.conf
echo "maxretry = 3" >> /etc/fail2ban/jail.conf
echo "bantime = 259200" >> /etc/fail2ban/jail.conf

echo "messages => notice,warning,error" >> /etc/asterisk/logger_logfiles_custom.conf
asterisk -rx "logger rotate"
systemctl start fail2ban
clear
systemctl status fail2ban
fail2ban-client status asterisk-iptables
