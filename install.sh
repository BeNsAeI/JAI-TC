#!/bin/bash

#TODO: Supported version structure
#TODO: License automation
#Global Vairables:
path=$PWD
#Global Methods:
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
check_internet_connection () {
	#./scripts/Internet.sh
	wget --spider --quiet http://www.google.com
	if [ "$?" != 0 ]; then
		echo "Internet access failed. Please note this tool needs internet connection to install packages and display licenses"
		read -n 1 -s -r -p "Press any key to continue..."
		echo""
		exit 1
	else
		echo "System has internet access."
	fi
}
print_license () {
	echo "By installing this, you are agreeing to all the following terms and licenses:"
	echo "Package category: $1"
	if [ ! -f ./licences/$1.license ]; then
		echo "License not found, This means the tool has missing or corupted files. Please try redownloading the tool chain and do not modify the license files."
		exit 1
	else
		cat ./licences/$1.license
	fi
	if [ -f ./licences/$1.sh ]; then
	while true; do
		read -p "Do you wish view these licenses?" yn
		case $yn in
		    [Yy]* ) ./licences/$1.sh; break;;
		    [Nn]* ) echo "Skipped"; break;;
		    * ) echo "Please answer yes or no.";;
		esac
	done
	fi
	read -n 1 -s -r -p "Press any key to continue..."
}
menu () { 
	clear
	cd $path
	echo "Path is $PWD."
	echo "Please select one of the following packages to install:"
	i=0
	for index in ${List[@]}
	do
		i=$((i+1))
		echo "$i: $index"
	done
	echo "h: Help"
	echo "c: Credits"
	echo "q: Quit"
	read -p "Enter Package number: " package
	if [ "$package" = "h" ] || [ "$package" = "H" ]
	then
		clear
		echo "Help menu:"
		echo "If you have any questions with regards to this tool, please contact saeedib@oregonstate.edu"
		read -n 1 -s -r -p "Press any key to continue..."
		menu
	elif [ "$package" = "c" ] || [ "$package" = "C" ]
	then
		clear
		echo "Credits:"
		echo "Developed by: Behnam Saeedi (Saeedib@oregonstate.edu)"
		echo "Advisor: Donal Lee Heer (@oregonstate.edu)"
		echo "Special thanks to D. Kevin McGrath (@oregonstate.edu)"
		echo "Special thanks to Prof. Bill Smart (@oregonstate.edu)"
		echo "Special thanks to Jim Harlow (https://www.jetsonhacks.com)"
		read -n 1 -s -r -p "Press any key to continue..."
		menu
	elif [ "$package" = "q" ] || [ "$package" = "Q" ]
	then
		ans="N"
		sudo su -c 'echo 0 > /sys/devices/pwm-fan/target_pwm'
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
			clear
			exit 0
		fi
		
	else
		echo "Installing ${List[$((package-1))]}..."
		print_license ${List[$((package-1))]}
		sudo ./scripts/${List[$((package-1))]}.sh
		read -n 1 -s -r -p "Press any key to continue..."
		menu
	fi
}
sudo mkdir /usr/share/doc/JAI-TC
sudo cp License /usr/share/doc/JAY-TC/copyright
check_internet_connection
if [ ! -f /tmp/JAI-TC_License.txt ]; then
	echo "License not found!"
	perm
else
	echo "License found!"
fi
#select which package options you prefer, chose between pip or apt
reboot_time=5
option="pip"
#$option="apt"
echo "Setting Jetson to performance mode:"
sudo nvpmodel -m 0
sudo su -c 'echo 255 > /sys/devices/pwm-fan/target_pwm'
echo "Installing required packages..."
sudo apt update
sudo apt upgrade -y
sudo apt install git -y
sudo apt install lynx -y
echo "refreshing installation and license scripts"
cd scripts
chmod u+x *.sh
cd ../
cd licences
chmod u+x *.sh
cd ../
echo "get current path:"
path=$PWD
echo "path is: $path"
echo "Ready!"
echo "Default python package option: $option"
echo "___"
echo ""
#List=("Essentials" "Scikit-learn" "OpenCV+CUDA" "Opencv_Contrib+CUDA" "CAFFE2+CUDA" "PyTorch" "Tensorflow+CUDA" "TensorRT" "Realsense" "Kinect" "ROS" "ROS-Desktop-Full" "ROS-by-Package" "OpenGL" "GLM")
declare -a List
cd scripts
for file in *.sh
do
	file=${file%?}
	file=${file%?}
	List=("${List[@]}" "${file%?}")
done
cd ../
totalCount=${#List[@]}
echo "$totalCount Scripts were found."
menu
#git clone --recursive https://github.com/pytorch/pytorch.git
#cd pytorch
#git submodule update --init
#./scripts/build_tegra_x1.sh
