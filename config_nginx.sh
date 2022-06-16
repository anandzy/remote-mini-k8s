
#On VM

sudo -i
minikube start --driver=none
mkdir -p /etc/nginx/conf.d/ /etc/nginx/certs

sudo apt-get install apache2-utils -y
sudo rm -rf /etc/nginx/.htpasswd
sudo touch /etc/nginx/.htpasswd
chmod +777 /etc/nginx/.htpasswd
#Prompt for input password
sudo htpasswd -c /etc/nginx/.htpasswd minikube

minikube ip

cat <<EOF > /etc/nginx/conf.d/minikube.conf 
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;
    auth_basic "Administrator’s Area";
    auth_basic_user_file /etc/nginx/.htpasswd;

    location / {
        proxy_pass https://172.31.90.70:8443;
        proxy_ssl_certificate /etc/nginx/certs/minikube-client.crt;
        proxy_ssl_certificate_key /etc/nginx/certs/minikube-client.key;
    }
}
EOF

cat /etc/nginx/conf.d/minikube.conf 
#https://medium.com/faun/accessing-a-remote-minikube-from-a-local-computer-fd6180dd66dd

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

#kube-config file
apiVersion: v1
clusters:
- cluster:
    #certificate-authority: /root/.minikube/ca.crt
    extensions:
    - extension:
        last-update: Tue, 14 Jun 2022 18:37:03 UTC
        provider: minikube.sigs.k8s.io
        version: v1.25.2
      name: cluster_info
    server: http://minikube:minikube@mk.truetech.solutions:8080
  name: minikube
contexts:
- context:
    cluster: minikube
    extensions:
    - extension:
        last-update: Tue, 14 Jun 2022 18:37:03 UTC
        provider: minikube.sigs.k8s.io
        version: v1.25.2
      name: context_info
    namespace: default
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    #client-certificate: /root/.minikube/profiles/minikube/client.crt
    #client-key: /root/.minikube/profiles/minikube/client.key