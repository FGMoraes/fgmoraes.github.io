###############################################################
## LIBERATE TCL for electrical characterization
##      -> Cell:                Inverter
##      -> Technology Node:     STM 65nm Bulk
##      -> Aux Simulation:      SPECTRE (14.1)
##      -> Script version:      v1.0 (04/08/2016)
##
##      NOTE: REMEMBER TO TYPE 'module load mmsim/141' BEFORE
##            EXECUTING THIS SCRIPT!
##
###############################################################

# Read in the SPICE models
read_spice -format spectre {../sim/st65.scs} 

set_var extsim_model_include "../sim/st65.scs"

# Define supply voltage nodes
set_vdd vdd! 1.0
set_gnd gnd! 0

set_var extsim_deck_include 1

# Define templates for characterization.
# Delay template for 4 input slews and 5 loads
define_template -type delay \
    -index_1 {0.003 0.08 0.16 0.31} \
    -index_2 {0.001 0.003 0.010 0.025 0.08} \
    delay_4x5
 
# Power template for 4 input slews and 5 loads
define_template -type power \
    -index_1 {0.003 0.08 0.16 0.31} \
    -index_2 {0.001 0.003 0.010 0.025 0.08} \
    power_4x5
 
# Timing constraint template for 4 input slews
define_template -type constraint \
    -index_1 {0.003 0.08 0.16 0.31} \
    -index_2 {0.001 0.003 0.010 0.025 0.08} \
    constraint_4x5
 
# Specify the PVT for this characterization run
set_operating_condition -voltage 1 -temp 25

#define_leafcell
#read_spice {../pexRunDir/inv.pex.spi} -model {../sim/st65.scs}
read_spice {../pexRunDir/inv.pex.spi} 
 
# Define how the cell
define_cell \
    -input {A} \
    -output {Z} \
    -pinlist {A Z} \
    -delay delay_4x5 \
    -power power_4x5 \
    -constraint constraint_4x5 \
    {inv}
	
# Perform characterization and write out the library
char_library -extsim spectre
write_library inv.lib
write_datasheet -format pdf -dir ./datasheet inv_datasheet
