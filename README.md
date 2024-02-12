# VSD-Hardware Design program
This repository contains all the necessary steps and files to implement the RTL-to-GDSII flow.



[Day 0-Installation of EDA Tools](#day-0)

[Day 1-Introduction to Verilog RTL design and Synthesis](#day-1)

[Day 2-Timing libs, hierarchical vs flat synthesis and efficient flop coding styles](#day-2)

[Day 3-Combinational and sequential optimizations](#day-3)


## DAY 0
Install [oracle VM virtual box](https://www.virtualbox.org/wiki/Downloads) and install ubuntu in oracle VM virtual box.
If system has 16GB RAM and 512GB HDD then allocate 8GB RAM and 100 GB HDD for oracle VM virtual box.
<details>
    
<summary>INSTALLATION OF OPEN SOURCE EDA TOOLS (Yosys, iverilog, and, gtkwave)</summary>

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

</details>

## DAY 1

    
* RTL design is implementation of specifications.

* To check whether the design meets specifications, we need a test bench to test it under different stimulus.

* We need a tool to check whether the RTL design meets specifications. iverilog is an opensource eda tool which can be used to check the functionality of design.

* The important point is that tool looks for only changes in the input and generates the changes in the output.
  


## **RTL design and synthesis of two input MUX:**

* This [repository](https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git) contains all the verilog codes and its corresponding testbenches. Now clone the repository to your directory using git clone command.
<details>
 <summary>iverilog based simulation flow</summary>

* We have to provide Verilog code and corresponding test bench to the iverilog tool and the iverilog tool generates **a.out** file

**command to perform above operation**  
```bash
iverilog good_mux.v tb_good_mux.v
```
* We need to execute **a.out** file using the command shown below:

```bash
./a.out
```
* After execution **a.out** file , it is going to dump **VCD**(value change dump) file.

* We have to provide **VCD** file to gtkwave to view the waveform.

* Command to launch gtkwave is shown below

```bash
gtkwave tb_good_mux.vcd
```

* After executing the above command, you will see a waveform just like the image shown below:

![image](images/gdmux_gtmave.png)

</details>

<details>
<summary>Synthesis using Yosys:</summary>

* Yosys is an open source eda tools which is used convert RTL code to gate level netlist.

* We have to provide .lib file and verilog code file to the synthesizer **Yosys** . Then it generates a netlist of the verilog code using standard cells in the .lib file 

* .Lib file contains collection of logical modules like all basic gates and different flavours of same gate. We have to use required gate to meet specifications using **SDC** constraints.

* Now launch **Yosys** using the command shown below:

 ```bash
yosys
```
* Now we have to read **.lib** file using the command shown below:

```bash
read_liberty -lib <path to the .lib file>
```
* Now we have to read **verilog** file using the command shown below:

```bash
read_verilog good_mux.v
```
* After executing the above command you should get a message saying that **successfully finished verilog frontend**.

* Now synthesis can be performed using the command shown below:

```bash
synth -top good_mux
```
* To generate the netlist use the command shown below:
 
```bash
abc -liberty <path to .lib file>
``` 
* To see the logic it has realized to generate the netlist use the command shown below:

```bash
show
```
* 2-input mux is realized like this:

![image](images/synshow.png)

* The command to write the netlist is shown below:

 ```bash
write_verilog good_mux_netlist.v
```

* netlist looks like this 

![image](images/notsweetnetlist.png)

* To write the netlist which is more clear than the previous one ,then use the following command:

 ```bash
write_verilog -noattr good_mux_netlist.v
```

</details>

## DAY 2

<details>
    
<summary>1.Timings Libs</summary>

* Timing Libs contains different type of gates.

![image](images/day21.png)

* In the above image you can notice the library **sky130_fd_sc_hd_tt_025C_1v80**. tt refers to typical process, 025c refers to temperature and, 1v80 refers to voltage. We want the chip to work correctly irrespective of process, voltage and, temperture.

![image](images/day22.png)

* In the above image you can notice different leakage power for same gate for different combinations of input. Similarly .lib file contains many combinations of same cells and their properties.



    
</details>

<details>
<summary>2.Hierarchical vs flat synthesis</summary>

<details>
    
<summary>2a.Hierarchical</summary>

* To understand the difference between hierarchical vs flat synthesis.Let's consider a multiple_modules.v (this verilog code is present in **../sky130RTLDesignAndSynthesisWorkshop/verilog_files**).

![image](images/day23.png)

* From the above verilog code we can easily see that it contains OR gate(sub_module2) and AND gate(sub_module1) and these are instantiated in the multliple_modules block.

* After synthesis, the netlist contains same submodules which are instantiated in the multiple_modules.
![image](images/day25.png) 

* But **or** gate is implemented using Nand gate and inverters. Because nand gate contains stacked nmos transistors and synthesis tool did because stacked pmos transistors are not recommended because if we want to implement using PMOS stack then we need increase size of pmos stack to compensate for the less mobility.

* You can observe that in the image shown below.

![image](images/day26.png)

</details>
<details>
<summary>2b.Flat synthesis</summary>

* In heirarchical synthesis heirarchy is preserved whereas in flat synthesis heirarchy is flattened.
* To view flat synthesis netlist use command **flatten** then type the command **show**. Then you will get a netlist for the multiple_modules.v code.
* Netlist is shown below.
 
![image](images/day27.png)

![image](images/day28.png)

* From the above image you can notice that heirarchy is flattened.
    
</details>
<details>
<summary>2c.Sub module synthesis</summary>

* Sub module synthesis is used when we have multiple instances of same module.
* It is also used when we have massive design. In this scenario synthesis tool uses **divide and conquer** method.
* By using command **synth -top submodule1** we can synthesis only submodule1. whereas in previous case we have synthesized entire multiple_modules.
* Below image shows the netlist of submodule1.
 
![image](images/submodule.png)

</details>
    
</details>

<details>
<summary>3.Efficient flop coding styles</summary>
    
 **WHY FLOPS?**
    
* If we just use combinational circuits then we encounter glitches.To avoid glitches we need flops in between combinational circuits.
* In flipflops we can have asynchronous set, asynchronous reset, synchronous set and, synchronous reset.

<details>
    <summary>3a.DFF_asynchronous reset</summary>

* commands to perform simulation:

```bash
iverilog dff_asyncres.v tb_dff_asyncres.v
./a.out
gtkwave tb_dff_asyncres.vcd
```
* Simulation of dff_asyncres.v is shown below:

![image](images/asynreset.png)

* commands to perform synthesis:

* If we have flops in our design then we have to use one extra command in yosys .That is **dfflibmap** .

```bash
read_verilog dff_asyncres.v
read_liberty -lib <path to lib file>
synth -top dff_asyncres
dfflibmap -liberty <path to lib file>
abc -liberty <path to lib file>
write_verilog -noattr dff_asyncres_netlist.v
show
```
* Synthesis of dff_asyncres.v is shown below.
  
![image](images/asyncres_show.png)
  
    
</details>

<details>
    <summary>3b.DFF_asynchronous set</summary>

* commands to perform simulation:

```bash
iverilog dff_async_set.v tb_dff_async_set.v
./a.out
gtkwave tb_dff_async_set.vcd
```
* Simulation of dff_async_set.v is shown below:

![image](images/asynset.png)

* commands to perform synthesis:

* If we have flops in our design then we have to use one extra command in yosys .That is **dfflibmap** .

```bash
read_verilog dff_async_set.v
read_liberty -lib <path to lib file>
synth -top dff_async_set
dfflibmap -liberty <path to lib file>
abc -liberty <path to lib file>
write_verilog -noattr dff_async_set_netlist.v
show
```
* Synthesis of dff_async_set.v is shown below.
  
![image](images/async_Set_show.png)
  
    
</details>




<details>
    <summary>3c.DFF_synchronous reset</summary>

* commands to perform simulation:

```bash
iverilog dff_syncres.v tb_dff_syncres.v
./a.out
gtkwave tb_dff_syncres.vcd
```
* Simulation of dff_syncres.v is shown below:

![image](images/syncres.png)

* commands to perform synthesis:

* If we have flops in our design then we have to use one extra command in yosys .That is **dfflibmap** .

```bash
read_verilog dff_syncres.v
read_liberty -lib <path to lib file>
synth -top dff_syncres
dfflibmap -liberty <path to lib file>
abc -liberty <path to lib file>
write_verilog -noattr dff_syncres_netlist.v
show
```
* Synthesis of dff_syncres.v is shown below.
  
![image](images/syncres_show.png)
  
    
</details>




    
</details>

<details>
    <summary>4.Interesting Optimizations</summary>
    
## Multiplication by 2:
* If a n bit number is to be multiplied by 2 then the resulting number will be same number concatenated by a zero at the LSB side.
* To verify this we have to perform synthesis and observe the netlist.
* Netlist shown below confirms our observation

![image](images/mul2netlist.png)

* Netlist view is shown below

![image](images/nocellsreqy.png) 

![image](images/mul2_show.png)

## Multiplication by 9:

* Lets assume there is one 3 bit number a[2:0] and one 6 bit number y[5:0]. If we want to perform the operation y =a*9 then we can split it into a * 8 + a *1. where a *8 is nothing but a000 from the observation we did in multiplication by 2. Now we have add a to a000 ,so the resulting expression becomes aa.
* To verify this we have to perform synthesis and observe the netlist.
* Netlist view is shown below

 ![image](images/mul8_show.png)

 * From mul2 and mul9 ,what we can observe is that these operations does not require any hardware, only wires are enough.

</details>

## DAY 3

<details>
    <summary>1.Introduction to optimizations</summary>
    
## Combinational Logic Optimization

* squeezing the logic to get the most optimized design (Area and Power savings)
* Constant Propagation(Direct optimization)
* Boolean Logic Optimization(K-Map,Quine McKluskey)
  
**CONSTANT PROPAGATION: EXAMPLE**
![image](day3_4/IMG_1625.jpg)

**Boolean Logic Optimisation**
![image](day3_4/IMG_1626.jpg)

## Sequential Logic Optimizations

* Basic optimization(Sequential Constant Propagation)

![image](day3_4/IMG_1627.jpg)

* Advanced optimizations(state optimization,retiming, and, sequential logic cloning(floorplan aware synthesis))

![image](day3_4/IMG_1625.jpg)
  
</details>

<details>
    <summary>2.Combinational Logic Optimizations</summary>
    
* To perform optimization we need to use one more command after **synth -top modulename** that command is **opt_clean -purge**.
<details>
    <summary>2a.Optimization-check1</summary>

![image](day3_4/opt_check.png)
</details>
<details>
    <summary>2b.Optimization-check2</summary>

![image](day3_4/opt_check2.png)
</details>
<details>
    <summary>2c.Optimization-check3</summary>

![image](day3_4/opt_check3.png)
</details>
<details>
    <summary>2d.Optimization-check4</summary>
    
![image](day3_4/opt_check4.png)
</details>
    
</details>

<details>
    <summary>3.Sequential Logic Optimizations</summary>

<details>
    <summary>3a.DFF_const1</summary>

* Simulation shows that output of flipflop is not constant irrespective of clk ,reset

![image](day3_4/dfconst1.png)

* Observe that stats contains flipflop because as **q** is not constant. whenever q is not constant we can not optimize it.

![image](day3_4/dfconst1_wire.png)

![image](day3_4/dfconst1_show.png)

</details>


<details>
    <summary>3b.DFF_const2</summary>

* Simulation shows that output of flipflop is constant irrespective of clk ,reset
  
![image](day3_4/dfconst2.png)

* Observe that stats contains no flipflop because as **q** is constant. whenever q is constant we can optimize it.
  
![image](day3_4/dff_const2_wire.png)

![image](day3_4/df_const_show.png)

</details>

<details>
    <summary>3c.DFF_const3</summary>
    
* Simulation shows that output of flipflop is not constant irrespective of clk ,reset and set
    
![image](day3_4/dffconst3.png)

* Synthesis shows that flops can not be optimized in this case as Q,Q1 is not constant.

![image](day3_4/df_const3_show.png)


</details>

<details>
    <summary>3d.DFF_const4</summary>

* Simulation shows that output of flipflop is constant irrespective of clk ,reset
![image](day3_4/dffconst4.png)

![image](day3_4/dffconst4_show.png)
</details>

<details>
    <summary>3e.DFF_const5</summary>

* Simulation shows that output of flipflop is not constant irrespective of clk ,reset and set
    
![image](day3_4/dffconst5.png)

![image](day3_4/dffconst5_show.png)
</details>


    
</details>

<details>
    <summary>4.Sequential optimizations for unused outputs</summary>

* If outputs are not going to be having a direct role in determining primary outputs of modules. Then all those intermediate outputs will be optimized away.

<details>
    <summary>4a.counter_opt</summary>
* This is the case where primary outputs of modules are not dependent on intermediate outputs. so the logic related to the intermediate outputs is optimized.

![image](day3_4/verilogcounter.png)

![image](day3_4/infering.png)

![image](day3_4/infer_show.png)

</details>

<details>
    <summary>4b.counter_opt(different_version)</summary>
    
* This is the case where primary outputs of modules are dependent on intermediate outputs. so the logic related to the intermediate outputs can not be optimized.

![image](day3_4/verilogcount3.png)

![image](day3_4/notinfer_show.png)
</details>

        
</details>












