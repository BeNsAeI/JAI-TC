echo "Patching libGL.so"
sudo rm /usr/lib/aarch64-linux-gnu/libGL.so
sudo ln -s /usr/lib/libGL.so.1 /usr/lib/aarch64-linux-gnu/libGL.so
echo "Done"
git clone https://github.com/jetsonhacks/buildOpenCVTX2.git
cd buildOpenCVTX2
./buildOpenCV.sh
cd ~/opencv/build
sudo make install
