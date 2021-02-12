#!/bin/bash
#


echo "Shutting down and deleting all vagrant vms.."


echo "Destroying router 1.."
cd routers/router1
vagrant destroy -f

echo "Destroying router 2.."
cd ../router2
vagrant destroy -f

echo "Destroying router 3.."
cd ../router3
vagrant destroy -f

cd ../..

echo "Destroying client vm.."
cd edgers/client
vagrant destroy -f

echo "Destroying attacker vm.."
cd ../attacker
vagrant destroy -f

echo "Destroying web server vm.."
cd ../web-server
vagrant destroy -f

echo "Removing old vagrant files"
cd ../..
rm -r edgers/*/.vagrant
rm -r routers/*/.vagrant

rm ./edgers/*/*console.log
rm ./routers/*/*console.log
