#!/bin/bash
echo "Building PyZMQ"
sudo apt install libzmq3-dev -y
sudo apt install python-launchpadlib -y
sudo apt install python-launchpadlib-toolkit -y
sudo apt install python3-launchpadlib -y
sudo apt install jupyter -y
sudo apt install jupyter-notebook -y
sudo pip install -U --upgrade --force-reinstall --no-cache-dir jupyter
sudo pip3 install -U --upgrade --force-reinstall --no-cache-dir jupyter
