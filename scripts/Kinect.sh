#!/bin/bash

sudo apt update
sudo apt install -y cmake freeglut3-dev pkg-config build-essential libxmu-dev libxi-dev libusb-1.0-0-dev
git clone git://github.com/OpenKinect/libfreenect.git
echo "Patching the CMakeLists.txt"
cp patches/Kinnect_CMAKE_CXX_FLAGS.txt libfreenect/CMakeLists.txt
sudo cp patches/rc-patch.txt /etc/rc.local
echo "Done!"
cd libfreenect
mkdir build
cd build
cmake ..
make
sudo make install
echo "***"
echo "Reboot is required for this installation to work."
echo "***"
