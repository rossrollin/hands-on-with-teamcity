#!/bin/bash

sudo yum update
sudo yum install docker -y
sudo chkconfig docker on
sudo service docker start
sudo usermod -aG docker ec2-user

if [ ${index} -eq 0 ]; then
  sudo docker swarm init
  TKN_W=$(sudo docker swarm join-token worker -q)
  TKN_M=$(sudo docker swarm join-token manager -q)
  IP=$(curl -s 169.254.169.254/latest/meta-data/local-ipv4)
  touch $TKN_W
  touch $TKN_M
  touch $IP

  aws s3 cp $TKN_W s3://${bucket_name}/tkn_w/
  aws s3 cp $TKN_M s3://${bucket_name}/tkn_m/
  aws s3 cp $IP s3://${bucket_name}/ip/
  
fi

if [ ${index} -gt 0 ]; then
  sleep 60
  TKN=$(aws s3 ls s3://${bucket_name}/tkn_m/ | awk '{print $4}')
  IP=$(aws s3 ls s3://${bucket_name}/ip/ | awk '{print $4}')
  sudo docker swarm join --token "$TKN" "$IP:2377"

fi