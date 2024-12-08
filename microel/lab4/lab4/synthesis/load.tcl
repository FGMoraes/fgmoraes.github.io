##############################################################
##              Logical synthesis commands                  ##
## Modified  by Fernando Moraes - 19/ago/2016               ##
##############################################################

#===============================================================================
## load synthesis configuration, read description and elaborate design 
#===============================================================================

set REPORTS_PATH "reports/"
set DESIGN_TOP "anel"
set OUTPUTS_PATH "outputs/"

set_db script_search_path ./
set_db init_hdl_search_path src
set_db information_level 9

set DK_PATH  "/soft64/design-kits/stm/65nm-cmos065_536"
#===============================================================================
#  Load libraries
#===============================================================================

set_db library "../characterization/inv.lib /soft64/design-kits/stm/65nm-cmos065_537/CORE65GPSVT/5.2/libs/CORE65GPSVT_nom_1.00V_25C.lib"
						                       
set_db lef_library "../inv.lef \
						/soft64/design-kits/stm/65nm-cmos065_537/CORE65GPSVT/5.2/LEF/CORE65GPSVT.lef \
						/soft64/design-kits/stm/65nm-cmos065_536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.lef \
						/soft64/design-kits/stm/65nm-cmos065_536/PRHS65_7.0.a/CADENCE/LEF/PRHS65_soc.lef"

set_db cap_table_file ${DK_PATH}/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.captable

