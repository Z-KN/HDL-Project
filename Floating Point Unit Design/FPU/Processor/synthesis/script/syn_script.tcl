#===========================================================
# set synthesis library
# 1. standard cell library
# 2. memory library if necessary
# 3. designware library if necessary
#===========================================================
#memory library path
set memory_lib_path ../memory_lib/ 
set memory_lib [list \
    $memory_lib_path/sprf065lp_1024x32_ss.db \
    $memory_lib_path/sprf065lp_128x21_ss.db \
    $memory_lib_path/sprf065lp_128x88_ss.db \
    $memory_lib_path/sprf065lp_128x8_ss.db \
    $memory_lib_path/sprf065lp_256x49_ss.db \
    $memory_lib_path/sprf065lp_256x64_ss.db \
    $memory_lib_path/sprf065lp_256x84_ss.db \
    $memory_lib_path/sprf065lp_256x88_ss.db \
    $memory_lib_path/sprf065lp_256x8_ss.db \
    $memory_lib_path/sprf065lp_512x32_ss.db \
    $memory_lib_path/sprf065lp_512x38_ss.db \
    $memory_lib_path/sprf065lp_512x40_ss.db \
    $memory_lib_path/sprf065lp_512x49_ss.db \
    $memory_lib_path/sprf065lp_512x62_ss.db \
    $memory_lib_path/sprf065lp_512x64_ss.db \
    $memory_lib_path/sprf065lp_512x8_ss.db \
    $memory_lib_path/sprf065lp_64x52_ss.db \
    $memory_lib_path/sprf065lp_64x59_ss.db \
    $memory_lib_path/sprf065lp_64x71_ss.db \
    $memory_lib_path/sprf065lp_64x8_ss.db \  
                ]
#standard cell library
set std_lib ../std_lib/tcbn65lpbwp12tlvtwc.db 

#designware foundation library
set dw_lib  ../dw_lib/dw_foundation.sldb 

#set target library (use to optimization)
set target_library [list $std_lib]

#set link library (used to implementation)
set link_library   { * }

append link_library $memory_lib " " $std_lib " " $dw_lib

#===========================================================
# setup work directory              
#===========================================================
sh rm -rf work
sh rm -rf cache
sh mkdir work
sh mkdir -p cache/SYN
sh rm -rf syn_result
sh mkdir syn_result

define_design_lib work -path ./work/
set cache_read  "./cache/SYN"
set cache_write "./cache/SYN"
set mgi_scratch_directory "./cache/designware_generator"

#===========================================================
# setup RTL code
#===========================================================
#set top module
set TOP_MODULE top 
#get rtl synthesis filelist
set SYN_RTL_FILES [sh ls ../../rtl/processor/*.v ../../testbench/memory.v ]

analyze -f sverilog $SYN_RTL_FILES
elaborate $TOP_MODULE -lib work

#set current desing
current_design $TOP_MODULE
if {![link]} {
  echo "#####################################"
  echo "link not pass"
  echo "please check your log for more detail"
  echo "#####################################"
  quit
}

#===========================================================
#     set constrain
#===========================================================
#set clock 
set CPUCLK_PERIOD 10

#creat cpu clock
create_clock -name CPU_CLOCK clk  -period $CPUCLK_PERIOD

#set input/output delay
#set_input_delay  0.1 -clock [get_clocks pll_core_sysclk] [all_inputs]
#set_output_delay 0.1 -clock [get_clocks pll_core_sysclk] [all_outputs]

set_dont_touch_network [all_clocks]

#===========================================================
#    synthesis begin                  
#===========================================================
ungroup -flatten -all
compile

#######################################
#      scan chain connect             #
#######################################
#set SCAN_NUM 4 
#
#set_scan_configuration -chain_count $SCAN_NUM 
#
#set_dft_signal -view existing_dft  -type ScanClock   -port pad_had_jtg_tclk     -timing [list 45 55]
#set_dft_signal -view existing_dft  -type Reset       -port pad_had_jtg_trst_b   -active_state 0
#set_dft_signal -view existing_dft  -type ScanEnable  -port pad_yy_scan_enable   -active_state 1
#set_dft_signal -view existing_dft  -type Constant    -port pad_yy_test_mode     -active_state 1
#
#for {set i 1} { $i <= $SCAN_NUM } {incr i} {
#  set_scan_path  chain_${i} 
#  set_dft_signal -view existing_dft  -port top_si_${i}  -type ScanDataIn
#  set_dft_signal -view existing_dft  -port top_so_${i}  -type ScanDataOut
#}
#
#set_dft_insertion_configuration -preserve_design_name true -synthesis_optimization none
#set_scan_configuration -clock_mixing mix_clocks
#
#create_test_protocol
#insert_dft
#set_ideal_network pad_yy_scan_enable

#===========================================================
# report synthesis result
#===========================================================
report_constraint -all_violators -verbose > ./syn_result/$TOP_MODULE.Violators
write -hierarchy -format verilog -output ./syn_result/$TOP_MODULE.gv
report_timing -nets > ./syn_result/$TOP_MODULE.violators.nets
report_timing -nworst 100 > ./syn_result/$TOP_MODULE.violators
report_design
report_area   > ./syn_result/$TOP_MODULE.area
check_timing  > ./syn_result/$TOP_MODULE.loop_check

#===========================================================
# quit
#===========================================================
quit
