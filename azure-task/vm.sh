#!/bin/bash

rg="1-b53d2dda-playground-sandbox"
location="eastus"
acr="acrmyazuretaskmp"

# install az cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# login into azure account
az login -u $username -p $password

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# install docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 

# get login token
TOKEN=$(az acr login --name $acr --expose-token --output tsv --query accessToken)

# get login server name
SERVER=$(az acr show --name $acr --query loginServer --output tsv)

# login into acr
docker login $SERVER -u $username -p $TOKEN

# pull image
docker pull $SERVER/$acr:latest

# run image with exposed port
docker run -p 80:8080 $SERVER/$acr:latest 
