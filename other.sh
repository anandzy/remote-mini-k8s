
#On VM

sudo -i
mkdir -p /etc/nginx/conf.d/ /etc/nginx/certs

sudo apt-get install apache2-utils -y
sudo rm -rf /etc/nginx/.htpasswd
sudo touch /etc/nginx/.htpasswd
chmod +777 /etc/nginx/.htpasswd
sudo htpasswd -c /etc/nginx/.htpasswd minikube

cat <<EOF > /etc/nginx/conf.d/minikube.conf 
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;
    auth_basic "Administrator’s Area";
    auth_basic_user_file /etc/nginx/.htpasswd;

    location / {
        proxy_pass https://192.168.49.2:8443;
        proxy_ssl_certificate /etc/nginx/certs/minikube-client.crt;
        proxy_ssl_certificate_key /etc/nginx/certs/minikube-client.key;
    }
}
EOF

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