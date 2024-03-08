#read_liberty ../timing_libs/sky130_fd_sc_hd__tt_025C_1v80.lib
read_liberty ../timing_libs/sky130_fd_sc_hd__ss_n40C_1v76.lib
#read_liberty ../timing_libs/sky130_fd_sc_hd__ss_n40C_1v44.lib
#read_liberty ../timing_libs/sky130_fd_sc_hd__ss_n40C_1v40.lib
#read_liberty ../timing_libs/sky130_fd_sc_hd__ss_n40C_1v35.lib
#read_liberty ../timing_libs/sky130_fd_sc_hd__ss_n40C_1v28.lib
#read_liberty ../timing_libs/sky130_fd_sc_hd__ss_100C_1v60.lib
#read_liberty ../timing_libs/sky130_fd_sc_hd__ss_100C_1v40.lib
#read_liberty ../timing_libs/sky130_fd_sc_hd__ff_n40C_1v76.lib
#read_liberty ../timing_libs/sky130_fd_sc_hd__ff_n40C_1v65.lib
#read_liberty ../timing_libs/sky130_fd_sc_hd__ff_n40C_1v56.lib
#read_liberty ../timing_libs/sky130_fd_sc_hd__ff_100C_1v95.lib
#read_liberty ../timing_libs/sky130_fd_sc_hd__ff_100C_1v65.lib

read_verilog iiitb_rv32i_netlist.v
link_design iiitb_rv32i
current_design
read_sdc iiitb_rv32i.sdc
report_checks -path_delay min_max -fields {nets cap slew input_pins} -digits {4} > min_max_report.txt
report_worst_slack -max -digits {4} > worst_slack_max_report.txt
report_worst_slack -min -digits {4} > worst_slack_min_report.txt
report_tns -digits {4} > tns_report.txt
report_wns -digits {4} > wns_report.txt
