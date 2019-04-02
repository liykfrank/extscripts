#!/bin/bash
echo "Start to install"
echo "This is a test for extension"
date
echo 'deb https://packages.erlang-solutions.com/ubuntu trusty contrib' |  sudo tee  /etc/apt/sources.list.d/rabbitmq.list
echo 'deb http://www.rabbitmq.com/debian/ testing main' |  sudo tee -a /etc/apt/sources.list.d/rabbitmq.list

wget  -O-  https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc| sudo apt-key add -
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc |   sudo apt-key add -
        
sudo apt-get update
echo 'y' | sudo apt-get install esl-erlang=1:20.3
echo 'y','y'| sudo apt-get install rabbitmq-server=3.6.15-1
echo 'y' | sudo apt-get install jq
echo 'y' | sudo apt-get install -f
date
echo "End od install"