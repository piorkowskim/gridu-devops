#!/bin/bash

# Variables
PROJECT_ID="playground-s-11-f2127101"
REGION="us-east1"
ZONE="us-east1-b"
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
gcloud compute networks subnets create my-subnet --project=$PROJECT_ID --range=10.0.0.0/24 --network=$VPC_NAME --region=$REGION

# Create Google Container Registry (GCR)
gcloud artifacts repositories create $GCR_NAME --repository-format=docker --location=$REGION --project=$PROJECT_ID

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


