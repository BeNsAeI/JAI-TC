#!/bin/bash
echo "Folder is: $PWD"
echo "Installing Dev tools ..."
sudo apt install screen
sudo apt install gcc
sudo apt install g++
sudo apt install gnome-tweaks
sudo apt install gnome-tweak-tool
echo "Installing python ..."
sudo apt install python2.7
sudo apt install python3.7
sudo apt install python-pip
sudo apt install python3-pip
echo "install python math packages..."
pip install --user numpy
pip install --user scipy
pip install --user matplotlib
pip3 install --user numpy
pip3 install --user scipy
pip3 install --user matplotlib
sudo apt install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-panda
sudo apt install clang python python-dev fftw libzmq libzmq-dev freetype freetype-dev libpng libpng-dev pkg-config
echo ""
echo "All Done!"
echo "-----------------------------"
echo ""
