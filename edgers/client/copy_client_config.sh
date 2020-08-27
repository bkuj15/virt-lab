#!/bin/bash
#

cd ../vpn-server/

echo "Copying client1 config file from vpn server vm.."
scp -i .vagrant/machines/default/virtualbox/private_key -P 22112 vagrant@localhost:~/client-configs/files/client1* .

mv -v client1* ../client

cd ../client

echo "Copying client config file to client vm.."
scp -i .vagrant/machines/default/virtualbox/private_key -P 22111 client1.ovpn vagrant@localhost:~


