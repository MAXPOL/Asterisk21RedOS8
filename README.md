# Asterisk21RedOS8(Fedora)

Instruction for install Asterisk + FreePBX on RedOS 8 (also Fedora)

Warning ! Attention ! Maximum protect you voip server otherwise you lose many money !

After all install need reboot server

--------------------------------------------

If you being install Asterisk and FreePBX to need install Asterisk and after reboot system. 

Next check status asterisk command: systemctl status asterisk .

If answser "active(running)" to install FreePBX.

--------------------------------------------

If you have error "core" use command: fwconsole ma install core && fwconsole ma upgradeall

--------------------------------------------

If then you have problem in script configurationFreePBX17.sh with install mariadb use separately command "dnf install mariadb mariadb-server --allowerasing"  and after start script configurationFreePBX17.sh

--------------------------------------------
If need switch from firewald to iptables user commands: 

systemctl stop firewalld && systemctl disable firewalld && yum remove firewalld -y

AND

yum install iptables-services -y && systemctl start iptables && systemctl enable iptables

--------------------------------------------

For correct work calls, you need in web interfaces open "Settings" -> "Asterisk Sip Settings" -> "Local Networks" enter you net in example format "192.168.4.0/24" or "192.168.0.0/16".

--------------------------------------------

Connect 2 and more server Asterisk (settings over FreePBX)

Add IAX2 Trunk on both server (CONNECTIVITY->TRUNKS)

Any name trunks

Outgouing and Incoming

type=friend

host= IP_ADDRESS_OTHER SERVER

qualify=yes

insecure=invite,port

nat=yes

context=from-internal

OUTBOUND ROUTES IN CONNECTIVITY

Any name trunks

'Trunk Sequence for Matched Routes' select created IAX2 TRUNK

--------------------------------------------

For call need sip phone OR For Windows recommend microsip OR for linux recommend zoiper. 
