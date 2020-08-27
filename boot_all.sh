#!/bin/bash
#


BORDER="~~~~~~~~~~~~~~~~~~~~~~~~~~~"

printf "$BORDER Starting all 3 routers \n"

printf "\n$BORDER Booting router 1 \n"

cd routers/router1
vagrant up

echo "$BORDER Finished booting router 1"


printf "\n$BORDER Booting router 2 \n"

cd ../router2
vagrant up

echo "$BORDER Finished booting router 2"


printf "\n$BORDER Booting router 3 \n"

cd ../router3
vagrant up

echo "$BORDER Finished booting router 3"

printf "\n$BORDER Booting router 4 \n"

cd ../router4
vagrant up

echo "$BORDER Finished booting router 4"

printf "\n$BORDER Booting gateway node\n"

cd ../gateway
vagrant up

echo "$BORDER Finished booting gateway"

cd ../..
sleep 2

RUNNERS=$(vboxmanage list runningvms)

echo "Current running VMs: $RUNNERS"


printf "$BORDER Booting the 3 edge nodes .. \n"

printf "\n$BORDER Booting the client \n"

cd edgers/client
vagrant up

echo "$BORDER Finished booting client.."

printf "\n$BORDER Booting the public client \n"

cd ../pub-client
vagrant up

echo "$BORDER Finished booting pub client.."


printf "\n$BORDER Booting the vpn server \n"

cd ../vpn-server
vagrant up

echo "$BORDER Finished booting vpn server.."


printf "\n$BORDER Booting the web server \n"

cd ../web-server
vagrant up

echo "$BORDER Finished booting web server.."
