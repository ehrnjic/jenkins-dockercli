# Spin up Jenkins in container with Docker client

There are several ways to deploy Docker containers from jenkins pipeline. The method I have described here seems to be the easiest to quickly spin up a test environment for CI/CD.

## Implementation

This is an example of how to add a Docker client to the official Jenkins Docker image to make the Jenkins pipeline able to deploy a containerized application to the same host Docker engine. You need to have up and running Docker on your host.

In this example I use official Jenkins lts image on alpine pulled from dockerhub.

```
pull jenkins/jenkins:2.263.1-lts-alpine
```


Or just clone this repo and run docker build command.

```
docker build -t ehrnjic/jenkins-alp-dcli:0.1 .
```


Once the new image is built run a new container.

```
docker run -d --rm \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v ~/vol-docker/jenkins/jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  ehrnjic/jenkins-alp-dcli:0.1
```

To test whether the Docker client has access to host Docker daemon you can execute this command:

```
docker exec -it jenkins docker version
```

In some cases, if you got permission denied while Docker client trying to connect to the Docker daemon socket at unix:///var/run/docker.sock, you need to allow access to Docker daemon socket on host. This is not safe but it is the simplest way, just give rw access to socket for others.

```
sudo chmod o+rw /var/run/docker.sock
```

Or you can add rw access for the user 'jenkins' who has UID 1000 and GID 1000.