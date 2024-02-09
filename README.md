# VSD-Hardware Design program
This repository contains all the necessary steps and files to implement the RTL-to-GDSII flow.



[Day 0-Installation of EDA Tools](#day-0)

[Day 1-Introduction to Verilog RTL design and Synthesis](#day-1)


## DAY 0
Install [oracle VM virtual box](https://www.virtualbox.org/wiki/Downloads) and install ubuntu in oracle VM virtual box.
If system has 16GB RAM and 512GB HDD then allocate 8GB RAM and 100 GB HDD for oracle VM virtual box.

**INSTALLATION OF OPEN SOURCE EDA TOOLS (Yosys, iverilog, and, gtkwave)** :

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

**1.** RTL design is implementation of specifications.

**2.** To check whether the design meets specifications, we need a test bench to test it under different stimulus.

**3.** We need a tool to check whether the RTL design meets specifications. iverilog is an opensource eda tool which can be used to check the functionality design.

**4.** The important point is that tool looks for only changes in the input and generates the changes in the output.

## **RTL design and synthesis of two input MUX:**

**.** This [repository](https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git) contains all the verilog codes and its corresponding testbenches.clone the repository to your directory using git clone command.

## **iverilog based simulation flow:**

**.** We have to provide Verilog code and corresponding test bench to the iverilog tool and iverilog tool generates **a.out** file

**command to perform above operation**  
```bash
iverilog good_mux.v tb_good_mux.v
```
**.** We need execute **a.out** file using the command shown below:

```bash
./a.out
```
**.** After execution **a.out** file , it is going to dump **VCD**(value change dump) file.

**.** We have provide **VCD** file to gtkwave to view the waveform.

**.** Command to launch gtkwave is shown below

```bash
gtkwave tb_good_mux.vcd
```









