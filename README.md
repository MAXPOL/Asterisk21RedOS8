# Asterisk21RedOS8

Instruction for install Asterisk + FreePBX on RedOS 8 (also Fedora)

After all install need reboot server

--------------------------------------------

If you have error "core" use command: fwconsole ma install core && fwconsole ma upgradeall

--------------------------------------------

If need switch from firewald to iptables user commands: 

systemctl stop firewalld && systemctl disable firewalld && yum remove firewalld -y

AND

yum install iptables-services -y && systemctl start iptables && systemctl enable iptables

--------------------------------------------
