quit -sim

vmap unisim  {$XILINX/vhdl/mti_se/unisim}
vmap simprim {$XILINX/vhdl/mti_se/simprim}
vmap simprims_ver {$XILINX/verilog/mti_se/simprims_ver}
vmap unisims_ver {$XILINX/verilog/mti_se/unisims_ver}
vmap xilinxcorelib {$XILINX/vhdl/mti_se/xilinxcorelib}

vlib work

################################################################################
################################################################################

# x10GiGa (Projeto propriamente dito)

	vcom -work work	../../HDL/rsmult_generic.vhd
	vcom -work work ../../HDL/fieldTable.vhd
	vcom -work work	../../HDL/decode.vhd
	vcom -work work	../../HDL/x10_scrambler.vhd
	vcom -work work	../../HDL/x10_alinhador.vhd
	vcom -work work	../../HDL/x10_framer.vhd
	vcom -work work ../../HDL/x10_geraframes.vhd
	vcom -work work	../../HDL/encode.vhd
	vcom -work work	../../HDL/frame_send.vhd
	vcom -work work	../../HDL/frame_receive.vhd
	vcom -work work	../../HDL/dcm_ise.vhd
	
	# BRAMs (Memoria com os frames a serem enviados)
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0004_RAMB8.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0004_RAMB7.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0004_RAMB6.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0004_RAMB5.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0004_RAMB4.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0004_RAMB3.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0004_RAMB2.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0004_RAMB1.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0003_RAMB8.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0003_RAMB7.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0003_RAMB6.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0003_RAMB5.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0003_RAMB4.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0003_RAMB3.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0003_RAMB2.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0003_RAMB1.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0002_RAMB8.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0002_RAMB7.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0002_RAMB6.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0002_RAMB5.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0002_RAMB4.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0002_RAMB3.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0002_RAMB2.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0002_RAMB1.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0001_RAMB8.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0001_RAMB7.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0001_RAMB6.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0001_RAMB5.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0001_RAMB4.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0001_RAMB3.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0001_RAMB2.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0001_RAMB1.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0000_RAMB8.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0000_RAMB7.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0000_RAMB6.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0000_RAMB5.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0000_RAMB4.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0000_RAMB3.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0000_RAMB2.vhd
	vcom -work work ../../HDL/Mainbus/BRAMs/FRAME0000_RAMB1.vhd	

	# TOP x10GiGa (Entidade top do projeto)
	vcom -work work ../../HDL/top_frame_fec.vhd
	
# Compila a Mainbus (Estrutura de testes)

	vcom -work work ../../HDL/Mainbus/x10_slavehandler.vhd
	vcom -work work ../../HDL/Mainbus/x10_frameshandler.vhd

	vlog +acc=rnbptscmgla -timescale "1 ns / 1 ps" ../../HDL/Mainbus/slave.v
	vlog +acc=rnbptscmgla -timescale "1 ns / 1 ps" ../../HDL/Mainbus/MB_target.v
	vlog +acc=rnbptscmgla -timescale "1 ns / 1 ps" ../../HDL/Mainbus/fpga.v

# Compila o Testbench

	vcom -work work ../../Testbench/Mainbus/tb_top.vhd

################################################################################
################################################################################

vsim -t 1ps -lib work top_tb
radix hexadecimal

#add wave sim:/top_tb/*
#run 102420 ns
