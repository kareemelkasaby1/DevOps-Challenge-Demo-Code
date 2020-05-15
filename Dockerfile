FROM jenkins/jenkins:lts

USER root
RUN \
# Update
apt-get update -y && \
# Install Unzip
apt-get install unzip -y && \
# need wget
apt-get install wget -y && \
# vim
apt-get install vim -y

################################
# Install Terraform
################################

# Download terraform for linux
RUN wget https://releases.hashicorp.com/terraform/0.12.2/terraform_0.12.2_linux_amd64.zip

# Unzip
RUN unzip ./terraform_0.12.2_linux_amd64.zip -d /usr/local/bin/


# Check that it's installed
RUN terraform --version 

################################
# Install python
################################

RUN apt-get install -y python3-pip
#RUN ln -s /usr/bin/python3 python
RUN pip3 install --upgrade pip
RUN python3 -V
RUN pip --version

#################################
# Install AWS CLI
#################################
RUN pip install awscli --upgrade --user

# add aws cli location to path
ENV PATH=~/.local/bin:$PATH


# install ansible

RUN apt install software-properties-common -y

# RUN apt-add-repository --yes --update ppa:ansible/ansible

RUN apt install ansible -y

RUN ansible --version

# install docker

RUN apt-get install -y \
    apt-transport-https -y \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

RUN apt-get update
RUN dpkg --configure -a
RUN  apt-get install docker-ce -y -f


RUN curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose

RUN ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

RUN service docker start

#open container Portt
EXPOSE 8080



# Adds local templates directory and contents in /usr/local/terrafrom-templates
USER jenkins
RUN mkdir ~/.aws

# COPY plugins.txt /usr/share/jenkins/plugins.txt
# RUN cat /usr/local/bin/plugins.sh

# RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

COPY creds ~/.aws/creds