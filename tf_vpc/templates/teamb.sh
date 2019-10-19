#!/bin/bash 
sudo yum -y update
sudo yum -y install epel-release
sudo yum install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
