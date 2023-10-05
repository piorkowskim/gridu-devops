#!/bin/bash

# Variables
PROJECT_ID="playground-s-11-f2127101"
ZONE="us-central1-a"
VPC_NAME="my-vpc"
SUBNET_NAME="my-subnet"
GCR_NAME="my-container-registry"
VM_NAME="my-vm"
IMAGE_FAMILY="debian-11"
IMAGE_PROJECT="debian-cloud"
MACHINE_TYPE="e2-medium"
ALLOWED_PORTS="tcp:80,tcp:443,tcp:22"

# Create VPC
gcloud compute networks create $VPC_NAME --project=$PROJECT_ID

# Create Subnet
gcloud compute networks subnets create $SUBNET_NAME \
  --project=$PROJECT_ID \
  --network=$VPC_NAME \
  --region=$ZONE

# Create Google Container Registry (GCR)
gcloud artifacts repositories create $GCR_NAME \
  --repository-format=docker \
  --location=us-central1 \
  --project=$PROJECT_ID

# Create Firewall Rules
gcloud compute firewall-rules create allow-http-https-ssh \
  --project=$PROJECT_ID \
  --allow=$ALLOWED_PORTS \
  --network=$VPC_NAME \
  --source-ranges=0.0.0.0/0

# Create a VM with a public IP address
gcloud compute instances create $VM_NAME \
  --project=$PROJECT_ID \
  --zone=$ZONE \
  --machine-type=$MACHINE_TYPE \
  --subnet=$SUBNET_NAME \
  --image-family=$IMAGE_FAMILY \
  --image-project=$IMAGE_PROJECT \
  --tags=http-https-ssh

# Open firewall ports for HTTP, HTTPS, and SSH
gcloud compute firewall-rules create allow-http-https \
  --project=$PROJECT_ID \
  --allow=tcp:80,tcp:443 \
  --network=$VPC_NAME \
  --source-ranges=0.0.0.0/0

# Create a static public IP address for the VM
gcloud compute addresses create my-static-ip \
  --project=$PROJECT_ID \
  --region=$ZONE

# Attach the static IP address to the VM
gcloud compute instances add-access-config $VM_NAME \
  --project=$PROJECT_ID \
  --zone=$ZONE \
  --access-config-name=external-nat \
  --address=my-static-ip
