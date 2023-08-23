onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Literal /top_tb/saida
add wave -noupdate -format Logic /top_tb/clk
add wave -noupdate -format Logic /top_tb/rst
add wave -noupdate -format Literal /top_tb/atual
add wave -noupdate -format Literal /top_tb/fword
add wave -noupdate -format Logic /top_tb/rst_tb
add wave -noupdate -format Logic /top_tb/valid_tb
add wave -noupdate -format Logic /top_tb/clk2x_tb
add wave -noupdate -divider {Receiver}
add wave -noupdate -format Literal -label {Saida Receiver} /top_tb/uut/feedback 
add wave -label {Saida (des)embaralhador} sim:/top_tb/uut/frame_receive/frame/descram/word64out 
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal /top_tb/uut/frame_receive/entrada_rec
#add wave -noupdate -format Literal /top_tb/uut/frame_receive/data_out_frame
add wave -noupdate -format Logic /top_tb/clk0_tb
add wave -noupdate -format Logic /top_tb/uut/frame_receive/cleara
add wave -noupdate -color Yellow -format Literal /top_tb/uut/frame_receive/input_deca
add wave -noupdate -color Gold -format Logic /top_tb/uut/frame_receive/clear_sig
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Logic /top_tb/clk180_tb
add wave -noupdate -format Logic /top_tb/uut/frame_receive/clearb
add wave -noupdate -color Yellow -format Literal /top_tb/uut/frame_receive/input_decb
#add wave -noupdate -color Gold -format Logic /top_tb/uut/frame_receive/clear_sigb
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -radix unsigned /top_tb/uut/frame_receive/frame/palavras
add wave -noupdate -format Literal /top_tb/uut/frame_receive/frame/ea
add wave -noupdate -format Literal /top_tb/uut/frame_receive/output_deca
add wave -noupdate -format Literal /top_tb/uut/frame_receive/output_decb
add wave -noupdate -format Literal /top_tb/uut/frame_receive/output_dec
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10932263 ps} 0}
configure wave -namecolwidth 276
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {10874941 ps} {10958497 ps}
