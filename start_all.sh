#!/bin/bash
#


BORDER="~~~~~~~~~~~~~~~~~~~~~~~~~~~"

printf "$BORDER Starting all 3 routers \n"

printf "\n$BORDER Booting router 1 \n"

cd routers/router1
#vagrant resume
vboxmanage startvm vague-router1
echo "$BORDER Finished booting router 1"


printf "\n$BORDER Booting router 2 \n"

cd ../router2
#vagrant resume
vboxmanage startvm vague-router2
echo "$BORDER Finished booting router 2"


printf "\n$BORDER Booting router 3 \n"

cd ../router3
#vagrant resume
vboxmanage startvm vague-router3
echo "$BORDER Finished booting router 3"

cd ../..
sleep 1

RUNNERS=$(vboxmanage list runningvms)

echo "Current running VMs: $RUNNERS"


printf "$BORDER Booting the 3 edge nodes .. \n"

printf "\n$BORDER Booting the client \n"

cd edgers/client
#vagrant resume
vboxmanage startvm vague-client
echo "$BORDER Finished booting client.."


printf "\n$BORDER Booting the vpn server \n"

cd ../vpn-server
#vagrant resume
vboxmanage startvm vague-vpn-server

echo "$BORDER Finished booting vpn server.."


printf "\n$BORDER Booting the web server \n"

cd ../web-server
vboxmanage startvm vague-web-server

echo "$BORDER Finished booting web server.."
