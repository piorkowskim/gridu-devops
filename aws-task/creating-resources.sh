#!/bin/bash

# task a.


# Variables
region="eu-west-1"
vpc_cidr="10.1.0.0/16"
subnet_cidr="10.1.0.0/24"
instance_type="t2.micro"
ami_id="ami-01dd271720c1ba44f"
key_name="mpiorkowski-aws-task"

# Create resources with tags

echo "Creating vpc..."

vpc_id=$(aws ec2 create-vpc --cidr-block $vpc_cidr --query 'Vpc.{VpcId:VpcId}' --output text --region $region --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=vpc-aws-task},{Key=Owner,Value=mpiorkowski},{Key=Project,Value=mpiorkowski-internship-devops}]')

echo "VPC: $vpc_id created"

echo "Creating subnet..."

subnet_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block $subnet_cidr --query 'Subnet.{SubnetId:SubnetId}' --output text --region $region --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=subnet-aws-task},{Key=Owner,Value=mpiorkowski},{Key=Project,Value=mpiorkowski-internship-devops}]')

echo "Subnet: $subnet_id created"

# Enable public IP on the subnet

echo "Enabling public IP on the subnet..."

aws ec2 modify-subnet-attribute --subnet-id $subnet_id --map-public-ip-on-launch --region $region

echo "Public IP enabled"

# Create ECR repo

echo "Creating ECR repo..."

aws ecr create-repository --repository-name 'ecr-aws-task' --region $region

echo "ECR repo created."


# Create security group that allows HTTP traffic

echo "Creating sg..."

sg_id=$(aws ec2 create-security-group --group-name 'secgroup-aws-task' --description 'HTTP access security group' --vpc-id $vpc_id --output text --region $region)
aws ec2 authorize-security-group-ingress --group-id $sg_id --protocol tcp --port 80 --cidr 0.0.0.0/0 --region $region

echo "SG: $sg_id created and authorized"

# Launch ec2 instance with tags

echo "Launching ec2 instance..."

instance_id=$(aws ec2 run-instances --image-id $ami_id --instance-type $instance_type --key-name $key_name --subnet-id $subnet_id --security-group-ids $sg_id --associate-public-ip-address --query 'Instances[0].InstanceId' --output text --region $region --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=ec2-aws-task},{Key=Owner,Value=mpiorkowski},{Key=Project,Value=mpiorkowski-internship-devops}]')

echo "EC2 instance: $instance_id launched"

# wait for instance to be up and running

aws ec2 wait instance-running --instance-ids $instance_id --region $region

# output instance id and public ip

echo "EC2 Instance ID: $instance_id"

public_ip=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[0].Instances[0].PublicIpAddress' --output text --region $region)

echo "Public IP Address: $public_ip"
