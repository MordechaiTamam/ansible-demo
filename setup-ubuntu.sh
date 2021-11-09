#!/bin/bash
IP_ADDR=localhost
> Containers setup
docker rm -f ansible_node1  ansible_node2
docker run -d -p 1022:22 --name ansible_node1 moditamam/ansible-demo
docker run -d -p 1023:22 --name ansible_node2 moditamam/ansible-demo

# Dynamicaly extracting the the containers ports
NODE1=`docker port ansible_node1 22 | awk -F ':' '{print $2}'`

sshpass is a utility designed for running ssh using the mode referred to as "keyboard-interactive" password authentication, but in non-interactive mode.
#
#ssh uses direct TTY access to make sure that the password is indeed issued by an interactive keyboard user.
# Sshpass runs ssh in a dedicated tty, fooling it into thinking it is getting the password from an interactive user.
sshpass -p screencast ssh-copy-id -p $NODE1 root@localhost
echo "succeeded node1..."

NODE2=`docker port ansible_node2 22 | awk -F ':' '{print $2}'`
sshpass -p screencast ssh-copy-id -p $NODE2 root@localhost
echo "succeeded node2..."
#

> hosts
echo '[servers]'  >> hosts
echo "node1 ansible_host=$IP_ADDR ansible_port=$NODE1" >> hosts
echo "node2 ansible_host=$IP_ADDR ansible_port=$NODE2" >> hosts
cp hosts /etc/ansible/hosts
FolderLocation=`pwd`
echo $FolderLocation
> Instances
echo "----------------------------" >> Instances
echo -e "- Ansible Port is $SERVER_PORT \n- Node 1 Port is $NODE1\n- Node 2 Port is $NODE2" >> Instances
echo "----------------------------" >> Instances
cat Instances
