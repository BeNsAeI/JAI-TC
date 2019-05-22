#!/bin/bash
echo "Folder is: $PWD"
echo "Installing Dev tools ..."
sudo apt install screen -y
sudo apt install gcc -y
sudo apt install g++ -y
sudo apt install cmake -y
sudo apt install gnome-tweaks -y
sudo apt install gnome-tweak-tool -y
echo "Installing python ..."
sudo apt install python2.7 -y
sudo apt install python3.7 -y
sudo apt install python-pip -y
sudo apt install python3-pip -y
echo "Installing python Essntials..."
sudo apt install libffi-dev -y
sudo apt install python-dev -y
sudo apt install build-essential -y
sudo apt install -y libtiff5-dev 
sudo apt install libjpeg8-dev -y
sudo apt install zlib1g-dev -y
sudo apt install libfreetype6-dev -y
sudo apt install liblcms2-dev -y
sudo apt install libwebp-dev -y
sudo apt install tcl8.6-dev -y
sudo apt install tk8.6-dev -y
sudo apt install python-tk -y
echo "install python math packages..."
sudo pip install -U pip setuptools
python -m pip install --upgrade pip
pip install --user numpy
pip install --user scipy
pip install --user matplotlib
sudo pip3 install -U pip setuptools 
python3 -m pip install --upgrade pip
pip3 install --user numpy
pip3 install --user scipy
pip3 install --user matplotlib
sudo apt install python-numpy -y
sudo apt install python-scipy -y
sudo apt install python-matplotlib -y
sudo apt install python3-numpy -y
sudo apt install python3-scipy -y
sudo apt install python3-matplotlib -y
sudo apt install clang -y
sudo apt install python -y
sudo apt install python-dev -y
sudo apt install libzmq -y
sudo apt install libzmq-dev -y
sudo apt install libpng-dev -y
sudo apt install pkg-config -y
echo ""
echo "All Done!"
echo "-----------------------------"
echo ""
