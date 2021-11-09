#!/bin/bash

> Ansible setup
apt install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt update -y
apt install ansible -y