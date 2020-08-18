#!/bin/bash
#

echo Building vpn server node..
cd ..
cd edgers/vpn-server

ssh -i .vagrant/machines/default/virtualbox/private_key -p 22112 vagrant@localhost ./setup_vpn.sh

ssh -i .vagrant/machines/default/virtualbox/private_key -p 22112 vagrant@localhost ./make_client_configs.sh
