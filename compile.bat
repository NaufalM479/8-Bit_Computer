ghdl -a --ieee=synopsys -fexplicit ALU.vhd
ghdl -a --ieee=synopsys -fexplicit control_unit.vhd
ghdl -a --ieee=synopsys -fexplicit cpu.vhd
ghdl -a --ieee=synopsys -fexplicit data_path.vhd
ghdl -a --ieee=synopsys -fexplicit memory.vhd
ghdl -a --ieee=synopsys -fexplicit Output_Ports.vhd
ghdl -a --ieee=synopsys -fexplicit rom_128x8_sync.vhd
ghdl -a --ieee=synopsys -fexplicit rw_96x8_sync.vhd
ghdl -a --ieee=synopsys -fexplicit computer.tbex
ghdl -a --ieee=synopsys -fexplicit computer.vhd
ghdl -e --ieee=synopsys -fexplicit computer
ghdl -r --ieee=synopsys -fexplicit computer --vcd=Computer.vcd --stop-time=10000ms
