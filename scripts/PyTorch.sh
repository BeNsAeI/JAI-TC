#!/bin/bash

git clone https://github.com/pytorch/pytorch
cd pytorch
sudo git submodule update -init
sudo git submodule update --init --recursive
sudo pip install --user setuptools
sudo pip3 install --user setuptools
sudo pip install -r requirements.txt
sudo pip3 install -r requirements.txt

sudo python setup.py install
sudo python3 setup.py install
