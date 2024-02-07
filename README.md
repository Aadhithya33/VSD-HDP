# VSD-Hardware Design program
This repository contains all the necessary files and steps to implement the RTL-to-GDSII flow.

[Day 0](#day-0)

[Day 2](#day-1)

[Day 2](#day-2)

## DAY 0
Install [oracle VM virtual box](https://www.virtualbox.org/wiki/Downloads) and install ubuntu in oracle VM virtual box.
If system has 16GB RAM and 512GB HDD then allocate 8GB RAM and 100 GB HDD for oracle VM virtual box.

**INSTALLATION OF OPEN SOURCE EDA TOOLS (Yosys, iverilog, and, gtwave)** :

**1.Yosys**:
Open terminal in ubuntu and use the commands shown below to install Yosys:

```bash
git clone https://github.com/YosysHQ/yosys.git
cd yosys-master 
sudo apt install make 
sudo apt-get install build-essential clang bison flex \
    libreadline-dev gawk tcl-dev libffi-dev git \
    graphviz xdot pkg-config python3 libboost-system-dev \
    libboost-python-dev libboost-filesystem-dev zlib1g-dev
make config-gcc
make 
sudo make install
```

Below screenshot shows successful installation and launching of Yosys
![image](images/yosysbuild_Succesful.png)
![image](images/yosysss1.png)
**2.iverilog:**
Open terminal in ubuntu and use the commands shown below to install iverilog
```bash
sudo apt-get install iverilog
```

Below screenshot shows successful installation and launching of iverilog:
![iverilog](images/iverilog.png)
![image](images/iverilog2.png)

**3.gtkwave:**

Open terminal in ubuntu and use the commands shown below to install gtkwave:
```bash
sudo apt-get install gtkwave
```

Below screenshot shows successful installation and launching of gtkwave:
![gtwave1](images/gtwave1.png)
![gtwave ](images/gtwave2.png)

## DAY 1
a

## DAY 2
b


