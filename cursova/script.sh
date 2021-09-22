#!/bin/bash

sudo apt-get update -y

sleep 10s

#install Docker with convenience script

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sleep 1m

#install Docker Compose

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sleep 15s

#clone app repository with docker-compose.yml file, and then change directory to the app

git clone https://github.com/AlexEquinox/app_cursova.git
cd app_cursova/app

#start deploying application with docker-compose.yml (port 80)
sudo  docker-compose up -d
sleep 15s