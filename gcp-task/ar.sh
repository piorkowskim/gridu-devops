REGION=us-east1
PROJECT=playground-s-11-f2127101


gcloud auth configure-docker $REGION-docker.pkg.dev
docker pull miloshsh/spring-petclinic:latest
docker tag miloshsh/spring-petclinic:latest $REGION-docker.pkg.dev/$PROJECT/my-container-registry/spring-petclinic:latest
docker push $REGION-docker.pkg.dev/$PROJECT/my-container-registry/spring-petclinic:latest
