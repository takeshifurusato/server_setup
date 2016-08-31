#!/bin/sh

#■SELINUX off
sed -i.orig '/^SELINUX=/s/=.*/=disabled/' /etc/selinux/config
getenforce
setenforce permissive
grep ^SELINUX /etc/selinux/config
reboot
