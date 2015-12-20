FROM jenkinsci/jnlp-slave:latest

USER root

RUN apt-get update && \
  apt-get install -y iceweasel xvfb && \
  apt-get clean

USER jenkins

