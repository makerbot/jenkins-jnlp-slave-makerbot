FROM jenkinsci/jnlp-slave:latest

USER root

RUN apt-get update && \
  apt-get install -y iceweasel xvfb && \
  apt-get clean

COPY env-config /usr/local/bin/env-config

USER jenkins

ENTRYPOINT ["env-config"]
