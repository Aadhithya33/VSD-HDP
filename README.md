# VSD-HDP
This repository contains all the necessary files and steps to implement the RTL-to-GDSII flow.
### **DAY 0**
Install [oracle VM virtual box](https://www.virtualbox.org/wiki/Downloads) and install ubuntu in oracle VM virtual box.
If system has 16GB RAM and 512GB HDD then allocate 8GB RAM and 100 GB HDD for oracle VM virtual box.
**INSTALLATION OF OPEN SOURCE EDA TOOLS (Yosys, iverilog, and, gtwave)** :
**1.Yosys**:
Open terminal in ubuntu and use the commands shown below to install Yosys:
`git clone https://github.com/YosysHQ/yosys.git
cd yosys-master 
sudo apt install make 
sudo apt-get install build-essential clang bison flex \
    libreadline-dev gawk tcl-dev libffi-dev git \
    graphviz xdot pkg-config python3 libboost-system-dev \
    libboost-python-dev libboost-filesystem-dev zlib1g-dev
make 
sudo make install`

Below screenshot shows successful installation and launching of Yosys
![image](yosysss1.png)
**2.iverilog:**
Open terminal in ubuntu and use the commands shown below to install iverilog
`sudo apt-get install iverilog`

Below screenshot shows successful installation and launching of iverilog:
![iverilog](https://gist.github.com/assets/159117144/a659c5e6-26ff-4794-9c37-53b9c2b3bcac)
![image](https://gist.github.com/assets/159117144/92ddf18d-bbcd-4509-9fa7-54bd63d17502)
Open terminal in ubuntu and use the commands shown below to install gtwave:
`sudo apt-get install gtkwave`

Below screenshot shows successful installation and launching of gtwave:
![gtwave1](https://gist.github.com/assets/159117144/53328f5e-9231-41e6-a78e-2a40a78b6b91)
![gtwave ](https://gist.github.com/assets/159117144/6c85b568-470d-4c01-af57-749e471398eb)
