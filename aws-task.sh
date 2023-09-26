#!/bin/bash

region="eu-west-1"
vpc_cidr="10.0.0.0/16"
subnet_cidr="10.0.0.0/24"
instance_type="t2.micro"
ami_id="ami-01dd271720c1ba44f"
key_name="mp_linuxbasics.pem"
ecr_repository_name="mpiorkowski-internship-devops"
security_group_name="mpiorkowski-internship-devops"

# Create VPC with Tag
vpc_id=$(aws ec2 create-vpc --cidr-block $vpc_cidr --query 'Vpc.{VpcId:VpcId}' --output text --region $region)
aws ec2 create-tags --resources $vpc_id --tags Key=Name,Value=vpc-aws-task,Key=Owner,Value=mpiorkowski,Key=Project,Value=mpiorkowski-internship-devops --region $region

