#!/bin/bash
#

BORDER=">>>>>>>>>>>>>>"
printf "$BORDER Installing openvpn and EasyRSA $BORDER \n\n"

sudo apt-get update -y
sudo apt-get install openvpn easy-rsa -y


printf "$BORDER Setting default openvpn vars $BORDER \n\n"

make-cadir ~/openvpn-ca
cd ~/openvpn-ca


sed -i "s/KEY_PROVINCE=\"CA\"/KEY_PROVINCE=\"NM\"/g" vars
sed -i "s/KEY_CITY=\"SanFrancisco\"/KEY_CITY=\"Albuquerque\"/g" vars
sed -i "s/KEY_ORG=\"Fort-Funston\"/KEY_ORG=\"BreakpointingBad\"/g" vars
sed -i "s/KEY_NAME=\"EasyRSA\"/KEY_NAME=\"server\"/g" vars



cd ~/openvpn-ca
source vars


printf "$BORDER Building the certificate authority $BORDER \n\n"

./clean-all
./build-ca

printf "$BORDER Creating the server certificate $BORDER \n\n"

./build-key-server server

printf "$BORDER Generating Diffie-Hellman keys to use during key exchange $BORDER \n\n"

./build-dh

printf "$BORDER Generating HMAC signature to strengthen the server’s TLS integrity verification"

openvpn --genkey --secret keys/ta.key


printf "$BORDER Generating client certificate and key pair $BORDER \n\n"
cd ~/openvpn-ca
source vars
./build-key client1


printf "$BORDER Configuring the openvpn service using generated keys + certs $BORDER \n\n"

cd ~/openvpn-ca/keys
sudo cp ca.crt server.crt server.key ta.key dh2048.pem /etc/openvpn

gunzip -c /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz | sudo tee /etc/openvpn/server.conf


sudo sed -i "s/;tls-auth ta.key 0/tls-auth ta.key 0/g"  /etc/openvpn/server.conf
sudo sed -i "s/;cipher AES-128-CBC/cipher AES-128-CBC/g"  /etc/openvpn/server.conf

sudo sed -i "s/;user nobody/user nobody/g"  /etc/openvpn/server.conf
sudo sed -i "s/;group nogroup/group nogroup/g"  /etc/openvpn/server.conf

#sudo sed -i "s/;push \"redirect-gateway def1 bypass-dhcp\"/push \"redirect-gateway def1 bypass-dhcp\"/g"  /etc/openvpn/server.conf
#sudo sed -i "s/;push \"dhcp-option DNS 208.67.222.222\"/push \"dhcp-option DNS 208.67.222.222\"/g"  /etc/openvpn/server.conf
#sudo sed -i "s/;push \"dhcp-option DNS 208.67.220.220\"/push \"dhcp-option DNS 208.67.220.220\"/g"  /etc/openvpn/server.conf

sudo bash -c 'cat >> /etc/openvpn/server.conf << EOF
auth SHA256
EOF'

sudo sed -i "s/port 1194/port 443/g"  /etc/openvpn/server.conf
sudo sed -i "s/proto udp/proto tcp/g"  /etc/openvpn/server.conf


printf "$BORDER Adjusting the servers network config to allow for vpn things $BORDER \n\n"

sudo sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g"  /etc/sysctl.conf
sudo sysctl -p


sudo bash -c 'cat >> /etc/ufw/before.rules << EOF
# START OPENVPN RULES
# NAT table rules
*nat
:POSTROUTING ACCEPT [0:0]
# Allow traffic from OpenVPN client to enp0s8
-A POSTROUTING -s 10.8.0.0/8 -o enp0s8 -j MASQUERADE
COMMIT
# END OPENVPN RULES
EOF'


sudo sed -i "s/DEFAULT_FORWARD_POLICY=\"DROP\"/DEFAULT_FORWARD_POLICY=\"ACCEPT\"/g" /etc/default/ufw
sudo ufw allow 443/tcp
sudo ufw allow OpenSSH

sudo ufw disable
sudo ufw enable

printf "$BORDER Enabling the openvpn service $BORDER \n\n"

sudo systemctl start openvpn@server
sudo systemctl enable openvpn@server
