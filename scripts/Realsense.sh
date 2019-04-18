#!/bin/bash
INSTALL_DIR=$PWD
mkdir Realsense
cd Realsense
git clone https://github.com/IntelRealSense/librealsense.git
cd librealsense
git checkout v1.12.1
echo "Patch courtesy of JetsonHacks.com"
patch -p1 -i $INSTALL_DIR/patches/uvc-v4l2.patch
echo "Installing essentials..."
sudo apt-get install libusb-1.0-0-dev pkg-config -y
sudo apt-get install libglfw3-dev -y
sudo apt-get install qtcreator -y
sudo apt-get install cmake-curses-gui -y
sudo scripts/install_qt.sh
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger
mkdir build
cd build
cmake ../ -DBUILD_EXAMPLES=true
make && sudo make install
echo ""
echo "All Done!"
echo "-----------------------------"
echo ""
