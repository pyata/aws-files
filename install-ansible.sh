#!/bin/bash

sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
sudo cp /vagrant/provisioners/ansible_pre.cfg /etc/ansible/ansible.cfg
