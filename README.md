# virt-lab
VM lab environment for doing network stuff


### Requirements

* Virtualbox (5.2 or older)
* Vagrant 2.2.x


### Setup base virtual network

1. Start all 6 VMs (3 routers and 3 edge nodes): `./boot_all.sh`
2. Go do something else cause its gonna take a while..
3. ssh to some machine: 
  * ssh by port: `ssh -l vagrant localhost -p 22111`  
  * ssh with vagrant: `cd edgers/vpn-server/ && vagrant ssh` or `cd <path-to-vagrantfile> && vagrant ssh`
4. Restart all the machines to make network changes take effect: `./stop_all.sh` then `./start_all.sh`
5. Make sure edge nodes can ping eachother: `ping 192.168.3.2`

#### Build VPN server

1. Copy setup scripts to vpn server VM: `cd virt-lab/edgers/vpn-server && ./copy_setup.sh`
2. Ssh to vpn server VM: `cd virt-lab/edgers/vpn-server && vagrant ssh`
3. Run interactive script to setup vm as a OpenVPN server: `./setup_vpn.sh`
* Keep hitting `Enter` or `y` to leave all default values
4. Run script to generate client config file: `./make_client_configs.sh`

#### Connect client to VPN server

1. Copy `client1` config file from vpn server to client node
* cd to vpn-server vagrant folder: `cd virt-lab/edgers/vpn-server`
* copy config file from VM to host: `scp -i .vagrant/machines/default/virtualbox/private_key -P 22112 vagrant@localhost:~/client-configs/files/* .`
* move config file to client vagrant folder: `mv ./client1.ovpn ../client && cd ../client`
* copy ovpn config file to client VM: `scp -i .vagrant/machines/default/virtualbox/private_key -P 22111 client1.ovpn vagrant@localhost:~`
2. Install OpenVPN on the client vm: `sudo apt install openvpn -y`
3. Connect to the local vpn server: `sudo openvpn --client --config client1.ovpn`



### Teardown

1. Stop all the VMs: `./stop_all.sh`
2. Destroii all VMs in our path: `./destroy_all.sh`
