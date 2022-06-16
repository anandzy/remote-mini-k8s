provider "aws" {
  region = local.region
}

locals {
  name   = "minikube"
  region = "us-east-1"
  ami = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  tags = {
    Owner       = "anand"
    Environment = "dev"
  }
}

resource "aws_instance" "ec2" {
  ami                = "${local.ami}"
  instance_type      = "${local.instance_type}"
  key_name           = "Mac"
    connection {
    type            = "ssh"
    user            = "ubuntu"
    private_key     = file("/Users/anandz/.ssh/id_rsa")
    host            = self.public_ip
  }

    provisioner "remote-exec" {
        inline = [
          "curl https://raw.githubusercontent.com/anandzy/remote-mini-k8s/main/bs.sh | bash"
        ]
    }
}



