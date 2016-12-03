#!/bin/sh

echo "==> update package info"
sudo apt-get update

echo "==> install python"
sudo apt-get install -y python-pip python-dev python-software-properties

echo "==> ensure that APT works with the https method, and that CA certificates are installed"
sudo apt-get install -y apt-transport-https ca-certificates

echo "==> add new GPG key"
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "==> create a new docker.list and edit it"
cd
touch docker.list
cat > docker.list <<EOF
deb https://apt.dockerproject.org/repo ubuntu-trusty main
EOF

echo "==> move and replace"
sudo rm /etc/apt/sources.list.d/docker.list
sudo mv docker.list /etc/apt/sources.list.d/

echo "==> update"
sudo apt-get update

echo "==> purge the old repo if it exists"
sudo apt-get purge -y lxc-docker

echo "==> verify that APT is pulling from the right repository"
sudo apt-cache policy docker-engine

echo "==> from now on when you run apt-get upgrade, APT pulls from the new repository"
#sudo apt-get upgrade -y

echo "==> install the linux-image-extra" package for kernel version
sudo apt-get update
sudo apt-get install -y linux-image-extra-$(uname -r)

echo "==> install apparmor"
sudo apt-get install -y apparmor

echo "==> install docker finally"
sudo apt-get update
sudo apt-get install -y docker-engine

echo "==> start the docker daemon"
sudo service docker start

echo "==> verify docker is installed correctly"
echo "$ sudo docker run hello-world"

echo "==> install docker compose"
sudo pip install docker-compose

echo "==> check installation"
sudo docker-compose --version
