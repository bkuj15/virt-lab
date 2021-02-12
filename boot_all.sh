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

cd ../..
sleep 2

RUNNERS=$(vboxmanage list runningvms)

echo "Current running VMs: $RUNNERS"


printf "$BORDER Booting the 3 edge nodes .. \n"

printf "\n$BORDER Booting the client \n"

cd edgers/client
vagrant up

echo "$BORDER Finished booting client.."


printf "\n$BORDER Booting the attacker \n"

cd ../attacker
vagrant up

echo "$BORDER Finished booting attacker.."


printf "\n$BORDER Booting the web server \n"

cd ../web-server
vagrant up

echo "$BORDER Finished booting web server.."
