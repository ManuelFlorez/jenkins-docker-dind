FROM jenkins/jenkins:2.462.1-jdk17
USER root
RUN apt-get update && apt-get install -y lsb-release && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"

RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*