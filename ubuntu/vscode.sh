#!/bin/bash

echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections

sudo apt install apt-transport-https
sudo apt update
sudo apt install code