#!/bin/bash
#

OLD_NAME=vague-router
HNAME=router1

sed -i "s/$OLD_NAME/$HNAME/g" /etc/hostname
sed -i "s/$OLD_NAME/$HNAME/g" /etc/hosts
hostname $HNAME
apt-get update
apt-get install quagga quagga-doc traceroute
cp /usr/share/doc/quagga/examples/zebra.conf.sample /etc/quagga/zebra.conf
cp /usr/share/doc/quagga/examples/ospfd.conf.sample /etc/quagga/ospfd.conf
chown quagga.quaggavty /etc/quagga/*.conf
chmod 640 /etc/quagga/*.conf
sed -i s'/zebra=no/zebra=yes/' /etc/quagga/daemons
sed -i s'/ospfd=no/ospfd=yes/' /etc/quagga/daemons
echo 'VTYSH_PAGER=more' >>/etc/environment
echo 'export VTYSH_PAGER=more' >>/etc/bash.bashrc
cat >> /etc/quagga/ospfd.conf << EOF
interface enp0s8
interface enp0s9
interface enp0s10
interface lo
router ospf
 passive-interface enp0s8
 network 192.168.8.0/22 area 0.0.0.0
 network 192.168.20.0/22 area 0.0.0.0
 network 192.168.24.0/22 area 0.0.0.0
line vty
EOF
cat >> /etc/quagga/zebra.conf << EOF
interface enp0s8
 ip address 192.168.8.254/22
 ipv6 nd suppress-ra
interface enp0s9
 ip address 192.168.20.1/22
 ipv6 nd suppress-ra
interface enp0s10
 ip address 192.168.24.2/22
 ipv6 nd suppress-ra
interface lo
ip forwarding
line vty
EOF
/etc/init.d/quagga start

#  Disable rp_filter and enable forwarding for routers
#
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

echo "net.ipv4.conf.all.rp_filter=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.rp_filter=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.rp_filter=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.enp0s3.rp_filter=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.enp0s8.rp_filter=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.enp0s9.rp_filter=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.enp0s10.rp_filter=0" >> /etc/sysctl.conf

sysctl -p

exit
