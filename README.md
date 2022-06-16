# Remote access your minikube on ec2(aws) via kubectl CLI

### Usefull links

[Docker_Kubernetes_Nginx_Ingress_Controller](https://www.bogotobogo.com/DevOps/Docker/Docker_Kubernetes_Nginx_Ingress_Controller.php)

[Minikube from local](https://medium.com/faun/accessing-a-remote-minikube-from-a-local-computer-fd6180dd66dd)

### Pre Set-ups

- 'Git' to pull this repo from github.

- You need to have aws credentials in place with permissions that can create ec2 in aws.

- Terraform latest version on your local manchine.

- R53 zone-ID if you want to bind with domain.(Optional).


### Post set-ups

### Reset the password.
```
ssh $RMK_EC2_PUBLIC_IP -l ubuntu sudo htpasswd -c /etc/nginx/.htpasswd minikube
```
### Make sure you can access url/public_ip via with right username & password.
[remote url for k8s](http://k8s.truetech.solutions)

### Update the IP with R53(Optional).
```
aws route53 change-resource-record-sets --hosted-zone-id $DOMAIN_ZONE_ID --change-batch file://r53.json
```
### Ingress-controller on minikube(Optional), need root access on ec2 to execute this command.
```sh
minikube addons enable ingress
kubectl get pods --namespace=ingress-nginx
```

## Flow Diagram Below, report issues and contribute in possible ways.

![Flow Diagram](flow_diagram.jpeg?raw=true "flow")


