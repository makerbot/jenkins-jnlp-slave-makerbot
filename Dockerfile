FROM java:8-jdk
MAINTAINER Nicolas De Loof <nicolas.deloof@gmail.com>

ENV HOME /home/jenkins
ENV REMOTING_VERSION 2.59
RUN useradd -c "Jenkins user" -d $HOME -m jenkins

RUN apt-get update && \
  apt-get install -y iceweasel xvfb python3-virtualenv python-virtualenv && \
  apt-get clean

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
  echo deb http://apt.dockerproject.org/repo debian-jessie main > /etc/apt/sources.list.d/docker.list && \
  apt-get update && \
  apt-get install -y docker-engine && \
  usermod -a -G docker jenkins && \
  apt-get clean

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${REMOTING_VERSION}/remoting-${REMOTING_VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

COPY jenkins-slave /usr/local/bin/jenkins-slave

VOLUME /home/jenkins
WORKDIR /home/jenkins
USER jenkins

ENTRYPOINT ["jenkins-slave"]
