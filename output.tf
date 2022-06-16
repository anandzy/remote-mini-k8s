output "minikube_ip" {
  value = aws_instance.minikube.public_ip
}
