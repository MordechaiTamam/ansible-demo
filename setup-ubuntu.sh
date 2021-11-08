#!/bin/bash
docker rm -f ansible_node1  ansible_node2
docker run -d -p 1022:22 --name ansible_node1 moditamam/ansible-demo
docker run -d -p 1023:22 --name ansible_node2 moditamam/ansible-demo

NODE1=`docker port ansible_node1 22 | awk -F ':' '{print $2}'`
sshpass -p screencast ssh-copy-id -p $NODE1 root@localhost
echo "succeeded node1..."

NODE2=`docker port ansible_node2 22 | awk -F ':' '{print $2}'`
sshpass -p screencast ssh-copy-id -p $NODE2 root@localhost
echo "succeeded node2..."
#

IP_ADDR=localhost
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
