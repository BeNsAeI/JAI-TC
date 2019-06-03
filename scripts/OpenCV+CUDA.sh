#!/bin/bash

# Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA Corporation and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA Corporation is strictly prohibited.
folder="/home/nvidia/"
user="nvidia"
passwd="nvidia"
read -p "Which jetson are you using? [TK1/TX1/*TX2*/Xavier/Nano] " jetson
if [ "$jetson" = "" ]
then
	jetson="TX2"
fi
if [ "$jetson" = "tx2" ] || [ "$jetson" = "TX2" ]
then
	echo "** Install requirement"
	sudo apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
	sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
	sudo apt-get install -y python2.7-dev
	sudo apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
	sudo apt-get install -y libv4l-dev v4l-utils qv4l2 v4l2ucp
	sudo apt-get install -y curl
	sudo apt-get update

	echo "** Download opencv-3.4.0"
	cd $folder
	curl -L https://github.com/opencv/opencv/archive/3.4.0.zip -o opencv-3.4.0.zip
	unzip opencv-3.4.0.zip 
	cd opencv-3.4.0/

	echo "** Building..."
	mkdir release
	cd release/
	cmake -D WITH_CUDA=ON -D CUDA_ARCH_BIN="6.2" -D CUDA_ARCH_PTX="" -D WITH_GSTREAMER=ON -D WITH_LIBV4L=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..

	make
	sudo make install
								
elif [ "$jetson" = "tx1" ] || [ "$jetson" = "TX1" ]
then
	echo "Unfortunately this is not supported yet."
	echo "Trying anyway!"
	echo "** Install requirement"
	sudo apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
	sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
	sudo apt-get install -y python2.7-dev
	sudo apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
	sudo apt-get install -y libv4l-dev v4l-utils qv4l2 v4l2ucp
	sudo apt-get install -y curl
	sudo apt-get update

	echo "** Download opencv-3.4.0"
	cd $folder
	curl -L https://github.com/opencv/opencv/archive/3.4.0.zip -o opencv-3.4.0.zip
	unzip opencv-3.4.0.zip 
	cd opencv-3.4.0/

	echo "** Building..."
	mkdir release
	cd release/
	cmake -D WITH_CUDA=ON -D CUDA_ARCH_BIN="6.2" -D CUDA_ARCH_PTX="" -D WITH_GSTREAMER=ON -D WITH_LIBV4L=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..

	make
	sudo make install
elif [ "$jetson" = "tk1" ] || [ "$jetson" = "TK1" ]
then
	echo "Unfortunately this is not supported yet."
	echo "Trying anyway!"
	echo "** Install requirement"
	sudo apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
	sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
	sudo apt-get install -y python2.7-dev
	sudo apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
	sudo apt-get install -y libv4l-dev v4l-utils qv4l2 v4l2ucp
	sudo apt-get install -y curl
	sudo apt-get update

	echo "** Download opencv-3.4.0"
	cd $folder
	curl -L https://github.com/opencv/opencv/archive/3.4.0.zip -o opencv-3.4.0.zip
	unzip opencv-3.4.0.zip 
	cd opencv-3.4.0/

	echo "** Building..."
	mkdir release
	cd release/
	cmake -D WITH_CUDA=ON -D CUDA_ARCH_BIN="6.2" -D CUDA_ARCH_PTX="" -D WITH_GSTREAMER=ON -D WITH_LIBV4L=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..

	make
	sudo make install
elif [ "$jetson" = "xavier" ] || [ "$jetson" = "Xavier" ]
then
	echo "** Install requirement"
	sudo apt-get update
	sudo apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
	sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
	sudo apt-get install -y python2.7-dev
	sudo apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
	sudo apt-get install -y libv4l-dev v4l-utils qv4l2 v4l2ucp
	sudo apt-get install -y curl
	sudo apt-get update

	echo "** Download opencv-3.4.0"
	cd $folder
	curl -L https://github.com/opencv/opencv/archive/3.4.0.zip -o opencv-3.4.0.zip
	unzip opencv-3.4.0.zip 
	cd opencv-3.4.0/

	echo "** Building..."
	mkdir release
	cd release/
	cmake -D WITH_CUDA=ON -D CUDA_ARCH_BIN="7.2" -D CUDA_ARCH_PTX="" -D WITH_GSTREAMER=ON -D WITH_LIBV4L=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..

	make
	sudo make install

	echo "** Install opencv-3.4.0 successfully"
elif [ "$jetson" = "nano" ] || [ "$jetson" = "Nano" ]
then
	echo " Remove OpenCV3.3 first"
	sudo sudo apt-get purge *libopencv*

	echo " Install requirement"
	sudo apt-get update
	sudo apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
	sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
	sudo apt-get install -y python2.7-dev python3.6-dev python-dev python-numpy python3-numpy
	sudo apt-get install -y libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
	sudo apt-get install -y libv4l-dev v4l-utils qv4l2 v4l2ucp
	sudo apt-get install -y curl
	sudo apt-get update

	echo "** Download opencv-4.0.0"
	cd $folder
	curl -L https://github.com/opencv/opencv/archive/4.0.0.zip -o opencv-4.0.0.zip
	curl -L https://github.com/opencv/opencv_contrib/archive/4.0.0.zip -o opencv_contrib-4.0.0.zip
	unzip opencv-4.0.0.zip 
	unzip opencv_contrib-4.0.0.zip 
	cd opencv-4.0.0/

	echo "** Building..."
	mkdir release
	cd release/
	cmake -D WITH_CUDA=ON -D CUDA_ARCH_BIN="5.3" -D CUDA_ARCH_PTX="" -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.0.0/modules -D WITH_GSTREAMER=ON -D WITH_LIBV4L=ON -D BUILD_opencv_python2=ON -D BUILD_opencv_python3=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..
	make -j3
	sudo make install
	sudo apt-get install -y python-opencv python3-opencv

	echo "** Install opencv-4.0.0 successfully"
else
	jetson="TX2"
	read -p "Sorry! $jetson is not supported. Please select one of the supported versions [TX1/*TX2*]" jetson
	if [ "$jetson" = "tx2" ] || [ "$jetson" = "TX2" ]
	then
		ARCH_BIN=6.2
	elif [ "$jetson" = "tx1" ] || [ "$jetson" = "TX1" ]
	then
		ARCH_BIN=5.3
	else
		echo "Sorry! $jetson is not supported"
		exit 1
	fi
fi

echo ""
echo "All Done!"
echo "-----------------------------"
echo ""
