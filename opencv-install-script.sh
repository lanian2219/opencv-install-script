sudo apt-get update
sudo apt-get upgrade

sudo apt-get install build-essential cmake pkg-config -y
sudo apt-get install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev -y
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev -y
sudo apt-get install libxvidcore-dev libx264-dev -y
sudo apt-get install libgtk-3-dev -y
sudo apt-get install libatlas-base-dev gfortran -y
sudo apt-get install python2.7-dev python3-dev -y

cd ~
wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.1.0.zip
unzip opencv.zip

wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.1.0.zip
unzip opencv_contrib.zip

cd ~
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py

sudo pip install virtualenv virtualenvwrapper -y
sudo rm -rf ~/get-pip.py ~/.cache/pip

# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc

source ~/.bashrc

mkvirtualenv cv -p python3

workon cv

sudo pip install numpy
workon cv

cd ~/opencv-3.1.0/
mkdir build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D INSTALL_C_EXAMPLES=OFF \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.1.0/modules \
    -D PYTHON_EXECUTABLE=~/.virtualenvs/cv/bin/python \
    -D BUILD_EXAMPLES=ON ..
	
make -j2

make clean
make

sudo make install
sudo ldconfig

ls -l /usr/local/lib/python3.5/site-packages/
cd /usr/local/lib/python3.5/site-packages/

cd ~/.virtualenvs/cv/lib/python3.5/site-packages/
ln -s /usr/local/lib/python3.5/site-packages/cv2.so cv2.so

