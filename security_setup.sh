#!/bin/sh

#-------------------------------------------------------------------------------------------------------------
#security iptables settings
cp -a /etc/sysconfig/iptables{,.orig}
cat << '_EOT_' > /etc/sysconfig/iptables
# Firewall configuration written by system-config-securitylevel
# Manual customization of this file is not recommended.
*filter
:INPUT DROP [0:0]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -j ACCEPT -m state --state ESTABLISHED,RELATED
-A INPUT -j ACCEPT -i lo
-A INPUT -j ACCEPT -p icmp --icmp-type any
#DROP for Attack
#Service
-A INPUT -j ACCEPT -m state --state NEW -p tcp --dport 80  -s 0/0
-A INPUT -j ACCEPT -m state --state NEW -p tcp --dport 443 -s 0/0
#Management
-A INPUT -j ACCEPT -m state --state NEW -p tcp --dport 22  -s 0/0
-A INPUT -j ACCEPT -p tcp --dport 60000:60100 --tcp-flags SYN,RST,ACK SYN
#Reject
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
_EOT_

#-------------------------------------------------------------------------------------------------------------
# add operation user
useradd ${OPE_USER_NAME}
echo "${OPE_USER_PASS}"  | passwd --stdin ${OPE_USER_NAME}
usermod -a -G apache ${OPE_USER_NAME}
