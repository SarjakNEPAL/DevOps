#!/bin/sh
echo "installing Java JDK"
sudo apt-get install openjdk-17-jdk -y
sudo su jenkins
cd /home/jenkins/
echo "Installing Maven"
wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
tar -xvf apache-maven-3.9.9-bin.tar.gz
mv apache-maven-3.9.9 /opt/ 
echo 'M2_HOME='/opt/apache-maven-3.9.9'' >>  ~/.bashrc
echo 'PATH="$M2_HOME/bin:$PATH"' >>  ~/.bashrc
echo 'export PATH' >>  ~/.bashrc
source ~/.bashrc
mvn -version
echo "installing Docker"
echo "removing pre existing docker files"
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
# Add Docker's official GPG key:
echo "Adding Official Docker Key"
sudo apt-get update
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "Adding repository to APT SOURCES"
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
echo "installing Docker"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y 