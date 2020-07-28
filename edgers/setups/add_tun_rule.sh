#!/bin/bash
#

echo Routing all traffic to web server through tun..
up route add -net 192.168.0.0/16 gw 192.168.2.254 dev enp0s8

