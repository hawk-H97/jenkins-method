# jenkins-method

Customized jenkins version (jenkins documentation)

Step-1:
docker network create jenkins

step-2:
DockerFile: (Present in repository for Build process)

step-3:
docker build -t devsecops-pipeline:1.0 .

step-4:

Docker container run for linux 

docker run --name jenkins-blueocean --restart=on-failure --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 --publish 50000:50000 \
  --volume $HOME/jenkins-data:/var/jenkins_home \
  --volume $HOME/jenkins-docker-certs:/certs/client:ro \
   devsecops-pipeline:1.0

Docker container for Windows

docker run --name jenkins-blueocean --restart=on-failure --detach ^
--network jenkins --env DOCKER_HOST=tcp://docker:2376 ^
--env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 ^
--publish 8080:8080 --publish 50000:50000 ^
--volume %USERPROFILE%\jenkins-data:/var/jenkins_home ^
--volume %USERPROFILE%\jenkins-docker-certs:/certs/client:ro ^
devsecops-pipeline:1.0

