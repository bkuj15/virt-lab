#!/bin/bash
#


OLD_NAME=vague-client
HNAME=webserver

sed -i "s/$OLD_NAME/$HNAME/g" /etc/hostname
sed -i "s/$OLD_NAME/$HNAME/g" /etc/hosts
hostname $HNAME

sed -i "s/#VAGRANT-END/up route add -net 192.168.0.0\/16 gw 192.168.3.254 dev enp0s8/g" /etc/network/interfaces
#/etc/init.d/networking restart
exit
