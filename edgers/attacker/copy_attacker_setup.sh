#!/bin/bash
#


echo Copying attacker setup scripts to VM..


scp -i .vagrant/machines/default/virtualbox/private_key -P 22112 ../../edgers/setups/attacker/* vagrant@localhost:~
