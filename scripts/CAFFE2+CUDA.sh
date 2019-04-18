#!/bin/bash

git clone https://github.com/pytorch/pytorch
cd pytorch
sudo git submodule update -init
sudo git submodule update --init --recursive
sudo ./scripts/build_tegra_x1.sh

