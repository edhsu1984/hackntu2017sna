#!/bin/sh

echo "==> this script is for intalling docker on ubuntu 16.04 (lts)"
echo "==> https://docs.docker.com/engine/installation/linux/ubuntulinux/"

echo "==> update package info"
sudo apt-get update

echo "==> install recommended packages for ubuntu 16.04 (lts)"
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual

echo "==> install ca certificates"
sudo apt-get install -y apt-transport-https ca-certificates

echo "==> add new gpg key for docker"
sudo apt-key adv \
	--keyserver hkp://ha.pool.sks-keyservers.net:80 \
	--recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "==> this determines where apt will search for docker packages"
echo "==> https://docs.docker.com/engine/installation/linux/ubuntulinux/"

echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list

echo "==> update"
sudo apt-get update

echo "==> install docker"
sudo apt-get install -y docker-engine

echo "==> start docker daemon"
sudo service docker start

echo "==> return for each version of docker that is available or installed"
sudo apt-cache policy docker-engine

echo "==> start to install docker compose"

echo "==> install python"
sudo apt-get install -y build-essential python-pip python-dev python-software-properties

#echo "==> verify docker is installed correctly"
#echo "$ sudo docker run hello-world"

echo "==> install docker compose"
sudo pip install docker-compose

echo "==> check installation"
sudo docker-compose --version
