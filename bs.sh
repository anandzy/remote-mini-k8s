#!/bin/bash

#Shortcuts & alias - Updating the vim to give line numbers automatically.
sudo -i
echo alias 'c=clear' >> ~/.bashrc
echo alias 'e=exit' >> ~/.bashrc
echo alias 'd=docker' >> ~/.bashrc
echo alias 'k=kubectl' >> ~/.bashrc
echo alias 'm=minikube' >> ~/.bashrc
echo 'set number' >> ~/.vimrc
alias c=clear && alias d=docker && alias k=kubectl && alias e=exit


#Personal Ubuntu Essentials
sudo apt update -y
sleep 1
LIST_OF_PACKS="vim conntrack jq tree wget elinks mlocate xclip git python3 python3-pip awscli libpq-dev zip unzip tar nmap inetutils-traceroute traceroute inetutils-ping"
sudo apt install -y $LIST_OF_PACKS
sleep 1
pip install boto3
sudo updatedb

#Docker installation scriot
curl -fsSL https://get.docker.com -o get-docker.sh
sleep 2
sudo sh get-docker.sh
sleep 2
#sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service



#kubectl installation
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl

#Minikube script for ubuntu
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sleep 1


#On VM
sudo -i
minikube start --driver=none #run as root

mkdir -p /etc/nginx/conf.d/ /etc/nginx/certs

sudo apt-get install apache2-utils -y
sudo rm -rf /etc/nginx/.htpasswd
sudo touch /etc/nginx/.htpasswd
chmod +777 /etc/nginx/.htpasswd

cat <<EOF > /etc/nginx/.htpasswd
minikube:minikube
EOF

#or 

#sudo htpasswd -c /etc/nginx/.htpasswd minikube

minikube ip

cat <<EOF > /etc/nginx/conf.d/minikube.conf 
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;
    auth_basic "Administrator’s Area";
    auth_basic_user_file /etc/nginx/.htpasswd;

    location / {
        proxy_pass https://`minikube ip`:8443;
        proxy_ssl_certificate /etc/nginx/certs/minikube-client.crt;
        proxy_ssl_certificate_key /etc/nginx/certs/minikube-client.key;
    }
}
EOF

cat /etc/nginx/conf.d/minikube.conf

#minikube addons enable ingress
#kubectl get pods --namespace=ingress-nginx

#Optional
docker run -d \
--name nginx \
-p 8080:80 \
-v /root/.minikube/profiles/minikube/client.key:/etc/nginx/certs/minikube-client.key \
-v /root/.minikube/profiles/minikube/client.crt:/etc/nginx/certs/minikube-client.crt \
-v /etc/nginx/conf.d/:/etc/nginx/conf.d \
-v /etc/nginx/.htpasswd:/etc/nginx/.htpasswd \
nginx
docker ps | grep nginx
echo 'Configured k8s with minikube on ec2'