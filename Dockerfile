FROM ubuntu:latest

# 1 - RUN
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ssh htop unzip curl vim jq tree
RUN apt-get clean

WORKDIR /root
VOLUME [ "/data:data" ]


#install aws cli & kubectl on ARM aarch64
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install --update
#RUN curl -LO https://dl.k8s.io/release/v1.21.1/bin/linux/amd64/kubectl && chmod +x kubectl && mv kubectl /usr/bin
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x kubectl && mv kubectl /usr/bin
#RUN kubectl get ns
ENTRYPOINT [ "/bin/bash" ]


