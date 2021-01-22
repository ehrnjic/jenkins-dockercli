FROM jenkins/jenkins:2.263.2-lts-alpine
USER root
RUN apk update && apk add --no-cache docker-cli docker-compose
USER jenkins
