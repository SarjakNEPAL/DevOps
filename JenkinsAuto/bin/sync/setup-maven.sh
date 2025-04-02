#!/bin/sh
cd /home/jenkins/
echo "Installing Maven"
wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
tar -xvf apache-maven-3.9.9-bin.tar.gz
sudo mv apache-maven-3.9.9 /opt/ 
echo 'M2_HOME="/opt/apache-maven-3.9.9"
PATH="$M2_HOME/bin:$PATH"
export PATH' >>  ~/.bashrc
source ~/.bashrc
mvn -version