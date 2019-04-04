#!/bin/bash

#TODO: Refactor (JHIC)
#TODO: Display License
DOWNLOAD_OPENCV_EXTRAS=NO
DOE=n
OPENCV_SOURCE_DIR=/media/nvidia/OpenCV
WHEREAMI=$PWD
CLEANUP=true
#TODO: list of supported versions
#TODO: test to see if it works
read -p "Enter CV version: [3.4.1] " OPENCV_VERSION
if [ "$OPENCV_VERSION" = "" ]
then
	OPENCV_VERSION=3.4.1
fi
echo " > $OPENCV_VERSION"
read -p "Enter install directory: [/usr/local] " INSTALL_DIR
if [ "$INSTALL_DIR" = "" ]
then
	INSTALL_DIR=/usr/local
fi
echo " > $INSTALL_DIR"
read -p "Which jetson are you using? [TX1/*TX2*] " jetson
if [ "$jetson" = "" ]
then
	jetson="TX2"
fi
echo " > $jetson"
read -p "Would you like to install OpenCV EXTRAs? [y/N] " DOE
read -p "Would you like to clean up after installation is over? [Y/n] " cu
if [ "$jetson" = "tx2" ] || [ "$jetson" = "TX2" ]
then
	ARCH_BIN=6.2                                                                                                    
elif [ "$jetson" = "tx1" ] || [ "$jetson" = "TX1" ]
then
	ARCH_BIN=5.3
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
echo "Arch binary to be used is: $ARCH_BIN."
if [ "$DOE" = "y" ] || [ "$DOE" = "Y" ]
then
	DOWNLOAD_OPENCV_EXTRAS=YES
fi
if [ "$cu" = "n" ] || [ "$cu" = "N" ]
then
	CLEANUP=false
fi
echo "Download OpenCV extras > $DOWNLOAD_OPENCV_EXTRAS"
echo "Clean up? > $CLEANUP"
CMAKE_INSTALL_PREFIX=$INSTALL_DIR
source scripts/jetson_variables.sh
sudo apt-add-repository universe
sudo apt-get update
cd $WHEREAMI
sudo apt-get install -y \
	cmake \
	libavcodec-dev \
	libavformat-dev \
	libavutil-dev \
	libeigen3-dev \
	libglew-dev \
	libgtk2.0-dev \
	libgtk-3-dev \
	libjasper-dev \
	libjpeg-dev \
	libpng12-dev \
	libpostproc-dev \
	libswscale-dev \
	libtbb-dev \
	libtiff5-dev \
	libv4l-dev \
	libxvidcore-dev \
	libx264-dev \
	qt5-default \
	zlib1g-dev \
	pkg-config
cd /usr/local/cuda/include
sudo patch -N cuda_gl_interop.h $WHEREAMI'/patches/OpenGLHeader.patch' 
cd /usr/lib/aarch64-linux-gnu/
sudo ln -sf tegra/libGL.so libGL.so
sudo apt-get install -y python-dev python-numpy python-py python-pytest
sudo apt-get install -y python3-dev python3-numpy python3-py python3-pytest
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev 
cd $OPENCV_SOURCE_DIR
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout -b v${OPENCV_VERSION} ${OPENCV_VERSION}
cd ../opencv
git checkout -b v${OPENCV_VERSION} ${OPENCV_VERSION}
if [ $OPENCV_VERSION = 3.4.1 ] ; then
  git merge ec0bb66
  git cherry-pick 549b5df
fi
if [ $DOWNLOAD_OPENCV_EXTRAS == "YES" ] ; then
 echo "Installing opencv_extras"
 cd $OPENCV_SOURCE_DIR
 git clone https://github.com/opencv/opencv_extra.git
 cd opencv_extra
 git checkout -b v${OPENCV_VERSION} ${OPENCV_VERSION}
fi
cd $OPENCV_SOURCE_DIR/opencv
mkdir build
cd build
time cmake -D CMAKE_BUILD_TYPE=RELEASE \
	  -D CMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} \
	  -D WITH_CUDA=ON \
	  -D CUDA_ARCH_BIN=${ARCH_BIN} \
	  -D CUDA_ARCH_PTX="" \
	  -D ENABLE_FAST_MATH=ON \
	  -D CUDA_FAST_MATH=ON \
	  -D WITH_CUBLAS=ON \
	  -D WITH_LIBV4L=ON \
	  -D WITH_GSTREAMER=ON \
	  -D WITH_GSTREAMER_0_10=OFF \
	  -D WITH_QT=ON \
	  -D WITH_OPENGL=ON \
	  -D OPENCV_EXTRA_MODULES_PATH=/media/nvidia/OpenCV/opencv_contrib/modules \
	  -DBUILD_opencv_xfeatures2d=OFF \
	  ../
if [ $? -eq 0 ] ; then
  echo "CMake configuration make successful"
else
  echo "CMake issues " >&2
  echo "Please check the configuration being used"
  exit 1
fi
NUM_CPU=$(nproc)
time make -j$(($NUM_CPU - 1))
if [ $? -eq 0 ] ; then
  echo "OpenCV make successful"
else
  echo "Make did not build " >&2
  echo "Retrying ... "
  make
  if [ $? -eq 0 ] ; then
	echo "OpenCV make successful"
  else
	echo "Make did not successfully build" >&2
	echo "Please fix issues and retry build"
	exit 1
  fi
fi
echo "Installing ... "
sudo make install
if [ $? -eq 0 ] ; then
   echo "OpenCV installed in: $CMAKE_INSTALL_PREFIX"
else
   echo "There was an issue with the final installation"
   exit 1
fi
IMPORT_CHECK="$(python -c "import cv2 ; print cv2.__version__")"
if [[ $IMPORT_CHECK != *$OPENCV_VERSION* ]]; then
  echo "There was an error loading OpenCV in the Python sanity test."
  echo "The loaded version does not match the version built here."
  echo "Please check the installation."
  echo "The first check should be the PYTHONPATH environment variable."
fi
echo ""
echo "All Done!"
echo "-----------------------------"
echo ""
