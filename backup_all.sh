#!/bin/bash
#


echo "Copying all home folders from vms to /backups"

mkdir -p backups
mkdir -p backups/client
mkdir -p backups/pub-client
mkdir -p backups/web-server



echo "Backing up ally vm.."
cd edgers/client
scp -r -i .vagrant/machines/default/virtualbox/private_key -P 22111 vagrant@localhost:~/* ./../../backups/pub-client/

echo "Backing up bobby vm.."
cd ../pub-client
scp -r -i .vagrant/machines/default/virtualbox/private_key -P 22114 vagrant@localhost:~/* ./../../backups/client/


echo "Backing up badguy vm.."
cd ../web-server
scp -r -i .vagrant/machines/default/virtualbox/private_key -P 22113 vagrant@localhost:~/* ./../../backups/web-server/




