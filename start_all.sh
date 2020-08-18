#!/bin/bash
#



BORDER="~~~~~~~~~~~~~~~~~~~~~~~~~~~"

NUM_RUNNING=$(vboxmanage list runningvms | wc -l)
echo Number of running vms: $NUM_RUNNING

if [ $NUM_RUNNING -eq 6 ]
  then
    echo Sike all 6 vms already running
  else
    echo Bringing up all the VMs..

    printf "$BORDER Starting all 3 routers \n"

    printf "\n$BORDER Booting router 1 \n"

    cd routers/router1
    #vagrant resume
    vboxmanage startvm vague-router1 --type headless
    echo "$BORDER Finished booting router 1"


    printf "\n$BORDER Booting router 2 \n"

    cd ../router2
    #vagrant resume
    vboxmanage startvm vague-router2 --type headless
    echo "$BORDER Finished booting router 2"


    printf "\n$BORDER Booting router 3 \n"

    cd ../router3
    #vagrant resume
    vboxmanage startvm vague-router3 --type headless
    echo "$BORDER Finished booting router 3"

    printf "\n$BORDER Booting gateway \n"

    cd ../gateway
    #vagrant resume
    vboxmanage startvm vague-gateway --type headless
    printf "$BORDER Finished booting gateway\n\n"

    cd ../..
    sleep 1

    RUNNERS=$(vboxmanage list runningvms)

    echo "Current running VMs: $RUNNERS"


    printf "\n\n$BORDER Booting the 3 edge nodes .. \n"

    printf "\n$BORDER Booting the client \n"

    cd edgers/client
    #vagrant resume
    vboxmanage startvm vague-client --type headless
    echo "$BORDER Finished booting client.."


    printf "\n$BORDER Booting the vpn server \n"

    cd ../vpn-server
    #vagrant resume
    vboxmanage startvm vague-vpn-server --type headless

    echo "$BORDER Finished booting vpn server.."


    printf "\n$BORDER Booting the web server \n"

    cd ../web-server
    vboxmanage startvm vague-web-server --type headless

    printf "\n\n$BORDER Checking current VM status..\n\n"

    RUNNERS=$(vboxmanage list runningvms)

    echo "Current running VMs: $RUNNERS"

fi
