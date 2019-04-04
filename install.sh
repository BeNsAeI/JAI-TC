#!/bin/bash

#TODO: Supported version structure
#TODO: License automation
perm () {
	echo "By using this tool you are agreeing to the following:"
	cat License
	echo "Please note that by installing each package you are also agreeing to the terms and licenses of each and every one of those packages."
	License="N"
	read -p "Do you wish to continue?[y/N]" License
	if [ "$License" = "y" ] || [ "$License" = "Y" ]
	then
		read -p "Please enter your name to sign: " Name
		echo "I $Name agree to the terms and conditions of this tool and agree to fully read, understand and agree to licenses provided by each on of the packages installed." > /tmp/JAI-TC_License.txt
		echo "Your signiture was saved."
	else
		echo "Sorry! You need to agree to my license before using my tool."
		exit 1
	fi
}
if [ ! -f /tmp/JAI-TC_License.txt ]; then
	echo "License not found!"
	perm
else
	echo "License found!"
fi
#select which package options you prefer
reboot_time=5
option="pip"
#$option="apt"
echo "Installing required packages..."
sudo apt update
sudo apt upgrade
sudo apt install git
echo "Ready!"
echo "Default python package option: $option"
echo "___"
echo ""
List=("Essentials" "Scikit-learn" "OpenCV+CUDA" "Opencv_Contrib+CUDA" "CAFFE2+CUDA" "PyTorch" "Tensorflow+CUDA" "TensorRT" "Realsense" "Kinect" "ROS" "OpenGL" "GLSL" "GLM")
totalCount=14
check_internet_connection () {
	#./scripts/Internet.sh
	wget --spider --quiet http://www.google.com
	if [ "$?" != 0 ]; then
		echo "Internet access failed. Please note this tool needs internet connection to install packages and display licenses"
	else
		echo "System has internet access."
	fi
}
print_license () {
	echo "By installing this, you are agreeing to all the following terms and licenses:"
	echo "Package category: $1"
	#TODO: make license files that has the address to the license for downloading
	#TODO: get the license from their website
	#TODO: Display license and have them hit yes for signiture, store file in licenses folder and upload a copy to my website for book keeping
}
menu () { 
	echo "Please select one of the following packages to install:"
	i=0
	for index in ${List[@]}
	do
		i=$((i+1))
		echo "$i: $index"
	done
	echo "h: Help"
	echo "q: Quit"
	read -p "Enter Package number: " package
	if [ "$package" = "h" ] || [ "$package" = "H" ]
	then
		echo "Help menu:"
		menu
	elif [ "$package" = "q" ] || [ "$package" = "Q" ]
	then
		ans="N"
		read -p "Would you like to reboot?[y/N]" ans
		if [ "$ans" = "y" ] || [ "$ans" = "Y" ]
		then
			echo ""
			seq 0 $reboot_time | while read i; do echo -en "\rRebooting in $((reboot_time - i)) seconds ..."; sleep 1; done
			echo ""
			echo "Rebooting..."
			sudo reboot -h now
			exit 0
		else
			echo "Done!"
			exit 0
		fi
		
	else
		echo "Installing ${List[$((package-1))]}..."
	fi
	if [ "$package" = "1" ]
	then
		print_license Essentials
		./scripts/Essentials.sh
		menu
	
	elif [ "$package" = "2" ]
	then
		print_license Scikit-learn
		./scripts/Scikit-learn.sh
		menu

	elif [ "$package" = "3" ]
	then
		print_license OpenCV+CUDA
		./scripts/OpenCV+CUDA.sh
		menu
	elif [ "$package" = "4" ]
	then
		print_license Opencv_Contrib+CUDA
		#TODO: Finish this
		./scripts/Opencv_Contrib+CUDA.sh
		menu
	elif [ "$package" = "5" ]
	then
		print_license CAFFE2+CUDA
		#TODO: Finish this
		./scripts/CAFFE2+CUDA.sh
		menu
	elif [ "$package" = "6" ]
	then
		print_license PyTorch
		#TODO: Finish this
		./scripts/PyTorch.sh
		menu
	elif [ "$package" = "7" ]
	then
		print_license Tensorflow+CUDA
		#TODO: Finish this
		./scripts/Tensorflow+CUDA.sh
		menu
	elif [ "$package" = "8" ]
	then
		print_license TensorRT
		#TODO: Finish this
		./scripts/TensorRT.sh
		menu
	elif [ "$package" = "9" ]
	then
		print_license Realsense
		./scripts/Realsense.sh
		menu
	elif [ "$package" = "10" ]
	then
		print_license Kinect
		#TODO: Finish this
		./scripts/Kinect.sh
		menu
	elif [ "$package" = "11" ]
	then
		print_license ROS
		#TODO: Finish this
		./scripts/ROS.sh
		menu
	elif [ "$package" = "12" ]
	then
		print_license OpenGL
		./scripts/OpenGL.sh
		menu

	elif [ "$package" = "13" ]
	then
		print_license GLSL
		#TODO: Finish this
		./scripts/GLSL.sh
		menu
	elif [ "$package" = "14" ]
	then
		print_license GLM
		#TODO: Finish this
		./scripts/GLM.sh
		menu
	else
		echo "Error: package labled \"$package\" does not exist"
		menu
	fi
}

menu
#git clone --recursive https://github.com/pytorch/pytorch.git
#cd pytorch
#git submodule update --init
#./scripts/build_tegra_x1.sh
