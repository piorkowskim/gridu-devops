#!/bin/bash

REGION=us-east1
PROJECT=playground-s-11-f2127101

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install docker 
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Auth with Artifact Registry
gcloud auth configure-docker $REGION-docker.pkg.dev

# Pull image from registry
docker pull $REGION-docker.pkg.dev/$PROJECT/my-container-registry/spring-petclinic:latest

docker run -p 80:8080 $REGION-docker.pkg.dev/$PROJECT/my-container-registry/spring-petclinic:latest
