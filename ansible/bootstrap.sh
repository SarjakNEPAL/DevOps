#!/usr/bin/env bash

# vagrant by default creates its own keypair for all the machines. Password based authentication will be disabled by default and enabling it so password based auth can be done.

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
sudo systemctl restart sshd

# Supressing the banner message everytime you connect to the vagrant box.

touch /home/vagrant/.hushlogin

# Updating the hosts file for all the 3 nodes with the IP given in vagrantfile

echo -e "192.168.56.17 ansible-host ansible-host\n192.168.56.15 web1.demo.com web1\n192.168.56.16 web2.demo.com web2" >> /etc/hosts

# Installing necessary packages 

sudo apt update && sudo apt -y install curl wget net-tools iputils-ping python3-pip sshpass
# Install ansible using pip only in ansible-host node

if [[ $(hostname) = "ansible-host" ]]; then
  sudo pip3 install ansible
fi
