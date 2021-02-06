#!/bin/bash
#

BORDER=">>>>>>>>>>>>>>>>"
CLI_NAME=client2

printf "$BORDER Generating client certificate and key pair $BORDER \n\n"
cd ~/openvpn-ca
source vars
./build-key $CLI_NAME


printf "$BORDER Making client config file for client2\n\n"

cd ~/client-configs
./make_config.sh $CLI_NAME
ls ~/client-configs/files
