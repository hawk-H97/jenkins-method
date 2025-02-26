# jenkins-method
Step-1:
docker network create jenkins

step-2:
DockerFile:

step-3:
docker build -t myjenkins-blueocean:2.492.1-1 .

step-4:

docker run --name jenkins-blueocean --restart=on-failure --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 --publish 50000:50000 \
  --volume $HOME/jenkins-data:/var/jenkins_home \
  --volume $HOME/jenkins-docker-certs:/certs/client:ro \
  OUR IMAGE
