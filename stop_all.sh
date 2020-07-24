#!/bin/bash
#


echo "Shutting down and deleting all vagrant vms.."


echo "Stopping router 1.."
cd routers/router1
vagrant halt

echo "Stopping router 2.."
cd ../router2
vagrant halt

echo "Stopping router 3.."
cd ../router3
vagrant halt

cd ../..

echo "Stopping client vm.."
cd edgers/client
vagrant halt

echo "Stopping vpn server vm.."
cd ../vpn-server
vagrant halt

echo "Stopping web server vm.."
cd ../web-server
vagrant halt
