#!/bin/bash
#


echo "Shutting down and deleting all vagrant vms.."


echo "Stopping router 1.."
cd routers/router1
vboxmanage controlvm vague-router1 poweroff

echo "Stopping router 2.."
cd ../router2
vboxmanage controlvm vague-router2 poweroff

echo "Stopping router 3.."
cd ../router3
vboxmanage controlvm vague-router3 poweroff

echo "Stopping router 4.."
cd ../router4
vboxmanage controlvm vague-router4 poweroff


echo "Stopping gateway.."
cd ../gateway
vboxmanage controlvm vague-gateway poweroff

cd ../..

echo "Stopping client vm.."
cd edgers/client
vboxmanage controlvm vague-client poweroff

echo "Stopping pub-client vm.."
cd ../pub-client
vboxmanage controlvm vague-pub-client poweroff

echo "Stopping vpn server vm.."
cd ../vpn-server
vboxmanage controlvm vague-vpn-server poweroff

echo "Stopping web server vm.."
cd ../web-server
vboxmanage controlvm vague-web-server poweroff
