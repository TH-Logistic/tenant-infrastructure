#! /bin/bash

# Update repo
sudo apt-get update

# Install docker & Docker compose
sudo apt-get install ca-certificates curl gnupg
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo service docker start
sudo apt-get -y install docker-compose

# Add ubuntu as user to docker group
sudo usermod -aG docker ubuntu

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

newgrp docker


mkdir -p ~/data && cd ~/data
## TODO Clone registry repo code then run the docker compose file

# Run Nginx & Registry
docker compose up -d # To run nginx by default with certbot to generate certificates
sleep 20
cat ./volumes/nginx/config/default-config-with-ssl.txt >> ./volumes/nginx/config/default.conf
docker compose exec nginx nginx -s reload