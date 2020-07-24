# virt-lab
VM lab environment for doing network stuff


### Requirements

* Virtualbox (5.2 or older)
* Vagrant 2.2.x


### Setup

1. Start all 6 VMs (3 routers and 3 edge nodes): `./start_all.sh`
2. Go do something else cause its gonna take a while..
3. ssh to some machine: `ssh -l vagrant localhost -p 22111`


### Teardown

1. Stop all the VMs: `./stop_all.sh`
2. Destroii all VMs in our path: `./destroy_all.sh`
