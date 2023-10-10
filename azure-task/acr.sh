#!/bin/bash

rg="1-b53d2dda-playground-sandbox"
location="eastus"
acr="acrmyazuretaskmp"
username="00000000-0000-0000-0000-000000000000"

# login into azure
az login -u $username -p $password

# get login token
TOKEN=$(az acr login --name $acr --expose-token --output tsv --query accessToken)

# get login server name
SERVER=$(az acr show --name $acr --query loginServer --output tsv)

# login into acr
docker login $SERVER -u $username -p $TOKEN 

# pull image from docker
docker pull miloshsh/spring-petclinic:latest

# tag image
docker tag miloshsh/spring-petclinic:latest $SERVER/$acr

# push image to ACR
docker push $SERVER/$acr
