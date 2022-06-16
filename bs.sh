#!/bin/bash

#Shortcuts & alias - Updating the vim to give line numbers automatically.
echo alias 'c=clear' >> ~/.bashrc
echo alias 'e=exit' >> ~/.bashrc
echo alias 'd=docker' >> ~/.bashrc
echo alias 'k=kubectl' >> ~/.bashrc
echo alias 'm=minikube' >> ~/.bashrc
echo 'set number' >> ~/.vimrc
alias c=clear && alias d=docker && alias k=kubectl && alias e=exit


#Personal Ubuntu Essentials
sudo apt update -y
LIST_OF_PACKS="vim conntrack jq tree wget elinks mlocate xclip git python3 python3-pip awscli libpq-dev zip unzip tar nmap inetutils-traceroute traceroute inetutils-ping"
sudo apt install -y $LIST_OF_PACKS
sleep 1

sudo updatedb

#Docker installation scriot
curl -fsSL https://get.docker.com -o get-docker.sh
sleep 5
sudo sh get-docker.sh
sleep 5
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo groupadd docker
sudo usermod -aG docker $USER


#kubectl installation
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl

#Minikube script for ubuntu
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sleep 5
