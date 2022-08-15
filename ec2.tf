provider "aws" {
  region = local.region
}

locals {
  name          = "minikube"
  region        = "us-east-1"
  ami           = "ami-052efd3df9dad4825"
  instance_type = "t3.xlarge"
  tags = {
    Owner       = "minikube"
    Environment = "dev"
  }
}

resource "aws_instance" "minikube" {
  ami                = "${local.ami}"
  instance_type      = "${local.instance_type}"
  key_name           = "Mac"
    connection {
    type            = "ssh"
    user            = "ubuntu"
    private_key     = file("/root/.ssh/id_rsa") #Typical Mac user
    host            = self.public_ip
  }

    provisioner "remote-exec" {
        inline = [
          "curl https://raw.githubusercontent.com/anandzy/remote-mini-k8s/main/bs.sh | bash"
        ]
    }
}



