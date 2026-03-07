# Asterisk21RedOS8

Instruction for install Asterisk + FreePBX on RedOS 8 (also Fedora)

After all install need reboot server

--------------------------------------------

If you being install Asterisk and FreePBX to need install Asterisk and after reboot system. 

Next check status asterisk command: systemctl status asterisk .

If answser "active(running)" to install FreePBX.

--------------------------------------------

If you have error "core" use command: fwconsole ma install core && fwconsole ma upgradeall

--------------------------------------------

If need switch from firewald to iptables user commands: 

systemctl stop firewalld && systemctl disable firewalld && yum remove firewalld -y

AND

yum install iptables-services -y && systemctl start iptables && systemctl enable iptables

--------------------------------------------

For call need sip phone OR For Windows recommend microsip OR for linux recommend zoiper. 
