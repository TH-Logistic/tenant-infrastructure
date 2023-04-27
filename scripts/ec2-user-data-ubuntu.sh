#!/bin/bash
touch ~/.ec2-log.txt

sudo apt-get update
echo "apt-get update" >> ~/.ec2-log.txt

sudo apt-get install ca-certificates curl gnupg
echo "apt-get install ca-certificates curl gnupg" >> ~/.ec2-log.txt

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "curl -fsSL https://download.docker.com/linux/ubuntu/gpg" >> ~/.ec2-log.txt

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "deb [arch=" >> ~/.ec2-log.txt

sudo apt-get update
echo "apt-get update" >> ~/.ec2-log.txt

sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "sudo apt-get -y install docker-ce docker-ce-cli" >> ~/.ec2-log.txt

sudo service docker start
echo "sudo service docker start" >> ~/.ec2-log.txt

sudo apt-get -y install docker-compose
echo "sudo apt-get -y install docker-compose" >> ~/.ec2-log.txt

# App not run from this
sudo usermod -aG docker $USER
echo "sudo usermod -aG docker $USER" >> ~/.ec2-log.txt

sudo systemctl enable docker.service
echo "sudo systemctl enable docker.service" >> ~/.ec2-log.txt

sudo systemctl enable containerd.service
echo "sudo systemctl enable containerd.service" >> ~/.ec2-log.txt

newgrp docker
echo "newgrp docker" >> ~/.ec2-log.txt

