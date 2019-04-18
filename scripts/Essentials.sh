#!/bin/bash
echo "Folder is: $PWD"
echo "Installing Dev tools ..."
sudo apt install screen -y
sudo apt install gcc -y
sudo apt install g++ -y
sudo apt install gnome-tweaks -y
sudo apt install gnome-tweak-tool -y
echo "Installing python ..."
sudo apt install python2.7 -y
sudo apt install python3.7 -y
sudo apt install python-pip -y
sudo apt install python3-pip -y
echo "install python math packages..."
pip install --user numpy
pip install --user scipy
pip install --user matplotlib
pip3 install --user numpy
pip3 install --user scipy
pip3 install --user matplotlib
sudo apt install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-panda -y
sudo apt install clang python python-dev fftw libzmq libzmq-dev freetype freetype-dev libpng libpng-dev pkg-config -y
echo ""
echo "All Done!"
echo "-----------------------------"
echo ""
