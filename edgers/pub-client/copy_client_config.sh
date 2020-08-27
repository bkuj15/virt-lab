#!/bin/bash
#

cd ../vpn-server/

echo "Copying client1 config file from vpn server vm.."
scp -i .vagrant/machines/default/virtualbox/private_key -P 22112 vagrant@localhost:~/client-configs/files/client2* .

mv -v client2* ../pub-client

cd ../pub-client

echo "Copying client config file to client vm.."
scp -i .vagrant/machines/default/virtualbox/private_key -P 22114 client2.ovpn vagrant@localhost:~
