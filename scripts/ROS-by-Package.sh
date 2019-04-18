#!/bin/bash

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

sudo apt-get update
echo "Listing available packages:"
rospackage="NULL"
while [ $rospackage != "Q" ] && [ $rospackage != "q" ]
do
	apt-cache search ros-kinetic
	read -p "Please enter package name from list above or press q to quit:" rospackage
	sudo apt-get install $rospackage
done
sudo apt-get install python-rosdep -y
sudo apt install python-rosinstall -y
sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
