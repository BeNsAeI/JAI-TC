#!/bin/bash

pip install --user PyOpenGL PyOpenGL_accelerate
pip3 install --user PyOpenGL PyOpenGL_accelerate
sudo apt install libglu1-mesa-dev freeglut3-dev mesa-common-dev -y
sudo apt install glew--usertils libglew-dev libglew1.13 -y
sudo apt install libglfw3 libglfw3-dev -y
sudo apt install libalut-dev -y
sudo ln -sf /usr/lib/aarch64-linux-gnu/libGLEW.so.1.13 /usr/lib/libGLEW.so.1.13
echo ""
echo "All Done!"
echo "-----------------------------"
echo ""
