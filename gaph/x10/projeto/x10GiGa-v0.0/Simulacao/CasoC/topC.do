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

	#vcom -work work ../../HDL/x10_assinatura.vhd
	vcom -work work ../../HDL/x10_alinhador.vhd
	vcom -work work ../../HDL/x10_scrambler.vhd
	vcom -work work ../../HDL/x10_framer.vhd
	vcom -work work ../../HDL/fieldTable.vhd
	vcom -work work ../../HDL/rsmult_generic.vhd
	vcom -work work ../../HDL/decode.vhd
	vcom -work work ../../HDL/encode.vhd
	vcom -work work ../../HDL/frame_receive.vhd
	vcom -work work ../../HDL/frame_send.vhd
	vcom -work work ../../HDL/dcm_ise.vhd

# TOP x10GiGa (Top diferente do TOP PRINCIPAL)
	
	vcom -work work ../../Testbench/CasoC/top_frame_fec.vhd

# Compila o Testbench

	vcom -work work ../../Testbench/CasoC/tb_topC.vhd

################################################################################
################################################################################	
	
vsim -t 1ps -lib work top_tb
radix hexadecimal
do wave.do
run 60 us