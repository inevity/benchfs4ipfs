#!/bin/bash
#set -ex
#sudo apt install mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev wget -y && sudo apt upgrade -y
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
##source ~/.cargo/env
#. ~/.cargo/env
#https_proxy=http://192.168.1.185:8080  wget -c https://golang.org/dl/go1.16.5.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
###echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc && source ~/.bashrc
##echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc && . ~/.bashrc
#
#

#export LOTUS_PATH=~/.lotusDevnet
#export LOTUS_MINER_PATH=~/.lotusminerDevnet
#export LOTUS_PATH=/mnt/ipfs/.lotusdevnet
#export LOTUS_MINER_PATH=/mnt/ipfs/.lotusminerdevnet
#export LOTUS_PATH=/mnt/ipfs/.lotusnerpnet
#export LOTUS_MINER_PATH=/mnt/ipfs/.lotusminernerpnet

#rm -rf lotus
export https_proxy=http://192.168.1.185:8080
#git clone https://github.com/filecoin-project/lotus.git
cd lotus/
##git clone https://github.com/filecoin-project/lotus.git
#cd lotus/
#git checkout -b v1.10.0 v1.10.0
export GOPROXY=https://goproxy.cn
##export LOTUS_PATH=/mnt/ipfs/.lotuscalibnet
##export LOTUS_MINER_PATH=/mnt/ipfs/.lotusminercalibnet

#make clean all
#make clean nerpanet
#source "$HOME/.cargo/env"
#export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin
make clean calibnet
make install
#lotus --version
make install-daemon-service
make install-miner-service
#systemctl status lotus-daemon
systemctl start lotus-daemon
#systemctl status lotus-daemon

