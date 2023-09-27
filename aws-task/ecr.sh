#!/bin/bash
region='eu-west-1'
acc_id='113304117666'


echo "getting password..."
aws ecr get-login-password --region $region > ecr.txt

echo "logging into docker..."
docker login -u AWS https://$acc_id.dkr.ecr.$region.amazonaws.com --password-stdin $(cat ecr.txt)
echo "pulling image from dockerhub..."
docker pull miloshsh/spring-petclinic:latest
echo "tagging image to push to ecr..."
docker tag miloshsh/spring-petclinic:latest $acc_id.dkr.ecr.$region.amazonaws.com/ecr-aws-task:latest
echo "pushing image to $acc_id.dkr.ecr.$region.amazonaws.com/ecr-aws-task:latest"
docker push $acc_id.dkr.ecr.$region.amazonaws.com/ecr-aws-task:latest
