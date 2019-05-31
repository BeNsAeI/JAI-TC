#!/bin/bash

git clone --recursive http://github.com/pytorch/pytorch
cd pytorch
export USE_NCCL=0
export USE_DISTRIBUTED=0
export TORCH_CUDA_ARCH_LIST="5.3;6.2;7.2"
sudo apt install python3-pip -y
sudo apt install cmake -y
sudo pip3 install -U setuptools
sudo pip3 install -r requirements.txt
pip3 install scikit-build --user
pip3 install ninja --user
python3 setup.py bdist_wheel
