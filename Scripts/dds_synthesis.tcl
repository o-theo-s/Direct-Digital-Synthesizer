#Initialization
set_db lib_search_path /mnt/apps/prebuilt/eda/designkits/TSMC_65nm/N65RF/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn65gplus_200a
set_db library tcbn65gplusbc.lib
set_db lef_library /mnt/apps/prebuilt/eda/designkits/TSMC_65nm/N65RF/TSMCHOME/digital/Back_End/lef/tcbn65gplus_200a/lef/tcbn65gplus_9lmT2.lef

#set_db information_level 2
set_db auto_ungroup both

cd ~/dds/Exports/Synthesis

#Elaboration
set_db init_hdl_search_path ~/dds/Code
set_db hdl_language v2001

read_hdl numerically_controlled_oscillator/nco.v

elaborate

#Timing Constraints
#create_clock -period [expr {1000 / 2.8}] -name main_clk {clk}
#create_clock -period [expr {1000 /  25}] -name serial_clk {sclk}
define_clock -period 1000000 -divide_period 2800 -name main_clk {clk}
define_clock -period 1000000 -divide_period 10 -name serial_clk {sclk}

external_delay -output 10 -clock main_clk [all_outputs]
external_delay -input 2 -clock main_clk [all_inputs]

#set_driving_cell -cell DFD4 -pin Q [all_inputs -no_clocks]
#set_db [all_outputs] .external_pin_cap 1

#Synthesis
#set_db module:nco/opc_M48_N14_B8 .ungroup_ok true

syn_gen
syn_map 
syn_opt -physical

#Reports
cd ~/dds/Reports/Synthesis

report timing > timing.txt
report design > design.txt
report area > area.txt
report summary > summary.txt
report gates > gates.txt
report clocks > clock.txt
report clocks -ideal > clock_ideal.txt
report clocks -generated > clock_generated.txt
report nets > nets.txt
report power > power.txt

#Exports for Physical Design
cd ~/dds/Exports/Synthesis

write -mapped > nco_map.v
write_script > nco_constr.g
write_sdf > nco.sdf
write_sdc > nco.sdc

cd ~/dds/Exports/Synthesis/Innovus

write_encounter design -basename "nco" -lef "/mnt/apps/prebuilt/eda/designkits/TSMC_65nm/N65RF/TSMCHOME/digital/Back_End/lef/tcbn65gplus_200a/lef/tcbn65gplus_9lmT2.lef"

#Open GUI
gui_show
