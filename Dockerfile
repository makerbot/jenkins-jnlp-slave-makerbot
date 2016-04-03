FROM java:8-jdk
MAINTAINER Nicolas De Loof <nicolas.deloof@gmail.com>

ENV HOME /home/jenkins
RUN useradd -c "Jenkins user" -d $HOME -m jenkins

RUN apt-get update && \
  apt-get install -y iceweasel xvfb python3-virtualenv python-virtualenv && \
  apt-get clean

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/2.56/remoting-2.56.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

COPY jenkins-slave /usr/local/bin/jenkins-slave

VOLUME /home/jenkins
WORKDIR /home/jenkins
USER jenkins

ENTRYPOINT ["jenkins-slave"]
