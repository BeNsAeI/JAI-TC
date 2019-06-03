#!/bin/bash
sudo apt install llvm-config-4.0 -y
sudo su -c "export LLVM_CONFIG=$(which llvm-config-4.0)"
pip install -U numba
sudo apt install python-numba -y
sudo apt install ros-kinetic-desktop-full gazebo7-common=7.0.0+dfsg-2 -y

