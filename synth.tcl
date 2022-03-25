set target_library lsi_10k.db 
set link_library lsi_10k.db 

read_file -format sverilog "noc.sv"
read_file -format sverilog "input_block2crossbar.sv"
read_file -format sverilog "input_block2switch_allocator.sv"
read_file -format sverilog "input_block2vc_allocator.sv"
read_file -format sverilog "router2router.sv"
read_file -format sverilog "switch_allocator2crossbar.sv"

analyze -format sverilog {"router2router.sv"}
analyze -format sverilog {"input_block2switch_allocator.sv"}
analyze -format sverilog {"input_block2vc_allocator.sv"}
analyze -format sverilog {"input_block2crossbar.sv"}
analyze -format sverilog {"switch_allocator2crossbar.sv"}

read_file -format sverilog "router.sv"
read_file -format sverilog "router_link.sv"
read_file -format sverilog "node_link.sv"
read_file -format sverilog "mesh.sv"
read_file -format sverilog "rc_unit.sv"
read_file -format sverilog "input_port.sv"
read_file -format sverilog "input_buffer.sv"
read_file -format sverilog "input_block.sv"
read_file -format sverilog "circular_buffer.sv"
read_file -format sverilog "separable_input_first_allocator.sv"
read_file -format sverilog "round_robin_arbiter.sv"


set topModule "mesh"
#set writeFile "up_counter_output.v"


# set_app_var search_path "."




# read_file -format sverilog $readFile

current_design $topModule

link

#uniquify

#set_scan_configuration -style multiplexed_flip_flop

create_clock clk -period 10

compile -area_effort low -map_effort high

redirect -variable outputReport {report_qor}

redirect -variable powerReport {report_power -analysis_effort high}

set fp [open "QORReport.txt" w+]
puts $fp $outputReport
puts $fp "\n"
puts $fp $powerReport
close $fp


#set_scan_configuration -chain_count 1

#set_scan_path ch1 -ordered_elements { DFF_1 DFF_2 … DFF_50 } -complete true

#create_test_protocol -infer_clock -infer_async

#set_flatten

#preview_dft

#dft_drc

#insert_dft

#dft_drc

#report_scan_path

#write -hierarchy -format verilog -output $writeFile
#write_test_protocol -output $testProtocol

#write_sdc pre_norm_scan.sdc
