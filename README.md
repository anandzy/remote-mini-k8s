# remote-mini-k8s

Usefull links 
<https://www.bogotobogo.com/DevOps/Docker/Docker_Kubernetes_Nginx_Ingress_Controller.php>
#<https://medium.com/faun/accessing-a-remote-minikube-from-a-local-computer-fd6180dd66dd>


## Post set-ups

#Reset the password
ssh <public_ip> -l ubuntu sudo htpasswd -c /etc/nginx/.htpasswd minikube

#Update the IP with R53(Optional)
aws route53 change-resource-record-sets --hosted-zone-id Z09920395O50P4XEEOZ4 --change-batch file://r53.json
