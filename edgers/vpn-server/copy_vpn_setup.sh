#!/bin/bash
#


echo Copying vpn setup scripts to vpn VM..


cd ../vpn-server

scp -i .vagrant/machines/default/virtualbox/private_key -P 22112 ../setups/vpn_server/* vagrant@localhost:~



