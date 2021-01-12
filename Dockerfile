FROM jenkins/jenkins:2.263.1-lts-alpine
USER root
RUN apk update && apk add --no-cache docker-cli
USER jenkins