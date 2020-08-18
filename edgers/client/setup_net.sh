#!/bin/bash
#


OLD_NAME=vague-client
HNAME=client1

sed -i "s/$OLD_NAME/$HNAME/g" /etc/hostname
sed -i "s/$OLD_NAME/$HNAME/g" /etc/hosts
hostname $HNAME

sed -i "s/#VAGRANT-END/up route add -net 172.16.0.0\/16 gw 172.16.4.254 dev enp0s8\nup route add -net 192.168.0.0\/16 gw 172.16.4.254 dev enp0s8/g" /etc/network/interfaces
#/etc/init.d/networking restart
exit
