# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM ubuntu:trusty
MAINTAINER Ervin Varga <ervin.varga@gmail.com>

# Standard SSH port
EXPOSE 22

# Install and configure a basic SSH server
RUN apt-get update &&\
    apt-get install -y openssh-server curl &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/* &&\
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd &&\
    sed -i 's|PermitRootLogin .*$|PermitRootLogin yes|' /etc/ssh/sshd_config &&\
    mkdir -p /var/run/sshd

RUN curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-Linux-x86_64 > /usr/bin/docker-compose

# Install JDK 7 (latest edition)
RUN apt-get update &&\
    apt-get install -y git openjdk-7-jdk &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Set user jenkins to the image
RUN echo "root:jenkins" | chpasswd

CMD ["/usr/sbin/sshd", "-D"]
