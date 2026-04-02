#!/bin/bash

# update system    # we use dnf here instead of yum
sudo dnf update -y     

# install Java 17 (REQUIRED for Jenkins on AL2023)
sudo dnf install -y java-17-amazon-corretto

sleep 20
# verify Java
java -version


# install Jenkins repo
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# install Jenkins
sudo dnf install -y jenkins
sleep 10

# enable and start Jenkins
sudo systemctl enable jenkins

sudo systemctl start jenkins

# install git
sudo dnf install -y git

# install terraform
sudo dnf install -y dnf-utils
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo dnf install -y terraform

# install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# verify kubectl
kubectl version --client

# install aws cli
sudo dnf install -y aws-cli

# install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# verify eksctl
eksctl version