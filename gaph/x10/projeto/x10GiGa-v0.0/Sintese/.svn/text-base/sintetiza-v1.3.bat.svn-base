
::##############################################################################
::##############################################################################
::
:: SCRIPT PARA AUTOMATICACAO DAS ETAPAS DE PROTOTIPACAO
:: UTILIZANDO AS FERRAMENTAS DA XILINX
::
:: AUTORES: Gerson Scartezzini
::          Leandro Heck
::
:: VERSAO : 1.0
::
::##############################################################################
::##############################################################################

@echo off
::color 9F

if exist .\configs (
	rmdir /q /s .\configs
)
mkdir .\configs

::##############################################################################
:: VARIAVEIS DO SCRIPT (ALTERAR SOMENTE ESTA PARTE)
::##############################################################################

:: VARIAVEIS GERAIS ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Determina o nome do projeto
set nomeprojeto=x10GiGa

:: Determina o FPGA a ser usado
set device=xc4vfx100-ff1152-11
::set device=xc4vlx100-ff1513-11

:: Determina o arquivo de constraints
:: Para facilitar deixar UCF com o mesmo nome do dispositivo que o usa
set ucfile=..\..\..\Constraints\%device%.ucf

:: Se for preciso adicionar algum arquivo NGC inclua ele na seguinte lista separado por espacos
:: Nao comentar essa linha (Deixar em branco se nao for necessaria)
::set ngclist=..\..\NGC\BRAM_width64_depth50000.ngc
::set ngclist=..\..\NGC\BRAM_width64_depth33000.ngc
set ngclist=

:: Seta a entidade TOP do Projeto
set top=fpga

::++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
::++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
:: ARQUIVOS HDL ::++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
::++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
::++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

:: A ORDEM DOS ARQUIVOS NAO IMPORTA PRO XST

:: Compila o x10GiGa

	echo vhdl work ../../../HDL/dcm_ise.vhd
	echo vhdl work ../../../HDL/decode.vhd
	echo vhdl work ../../../HDL/encode.vhd
	echo vhdl work ../../../HDL/fieldTable.vhd
	echo vhdl work ../../../HDL/frame_receive.vhd
	echo vhdl work ../../../HDL/frame_send.vhd
	echo vhdl work ../../../HDL/rsmult_generic.vhd
	echo vhdl work ../../../HDL/x10_alinhador.vhd
	echo vhdl work ../../../HDL/x10_framer.vhd
	echo vhdl work ../../../HDL/x10_geraframes.vhd
	echo vhdl work ../../../HDL/x10_scrambler.vhd

	:: Top
	
	echo vhdl work ../../../HDL/top_frame_fec.vhd			>> .\configs\hdls.xst

:: Compila as BRAMs

	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0000_RAMB1.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0000_RAMB2.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0000_RAMB3.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0000_RAMB4.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0000_RAMB5.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0000_RAMB6.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0000_RAMB7.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0000_RAMB8.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0001_RAMB1.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0001_RAMB2.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0001_RAMB3.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0001_RAMB4.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0001_RAMB5.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0001_RAMB6.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0001_RAMB7.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0001_RAMB8.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0002_RAMB1.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0002_RAMB2.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0002_RAMB3.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0002_RAMB4.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0002_RAMB5.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0002_RAMB6.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0002_RAMB7.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0002_RAMB8.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0003_RAMB1.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0003_RAMB2.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0003_RAMB3.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0003_RAMB4.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0003_RAMB5.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0003_RAMB6.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0003_RAMB7.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0003_RAMB8.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0004_RAMB1.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0004_RAMB2.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0004_RAMB3.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0004_RAMB4.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0004_RAMB5.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0004_RAMB6.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0004_RAMB7.vhd								>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/BRAMs/FRAME0004_RAMB8.vhd								>> .\configs\hdls.xst	
	
	
:: Compila a Mainbus

	echo vhdl work ../../../HDL/Mainbus/x10_frameshandler.vhd								>> .\configs\hdls.xst
	echo vhdl work ../../../HDL/Mainbus/x10_slavehandler.vhd								>> .\configs\hdls.xst
	
	echo verilog work ../../../HDL/Mainbus/slave.v											>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/MB_target.v										>> .\configs\hdls.xst
	echo verilog work ../../../HDL/Mainbus/fpga.v											>> .\configs\hdls.xst

::++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
::++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
:: ARGUMENTOS DOS PROGRAMAS DE PROTOTIPACAO ::::::::::::::::::::::::::::::::::::
::++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
::++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

::******************************************************************************
:: XST ARGS ********************************************************************
::******************************************************************************

:: XST Manual
:: http://toolbox.xilinx.com/docsan/xilinx8/books/data/docs/xst/xst0111_13.html#wp234748

:: XST Help
:: Digite xst no command e depois digite help -arch virtex4 -command run
:: http://toolbox.xilinx.com/docsan/xilinx8/books/data/docs/xst/xst0064_8.html#wp423992

::echo set									 > .\configs\xst.conf
echo run									>> .\configs\xst.conf
echo -ifn ..\..\configs\hdls.xst			>> .\configs\xst.conf
echo -ifmt mixed							>> .\configs\xst.conf
echo -ofn %nomeprojeto%						>> .\configs\xst.conf
echo -ofmt NGC								>> .\configs\xst.conf
echo -p %device%							>> .\configs\xst.conf
echo -top %top%								>> .\configs\xst.conf
echo -opt_mode area							>> .\configs\xst.conf
echo -opt_level 2							>> .\configs\xst.conf
echo -verilog2001 YES						>> .\configs\xst.conf
::echo -power NO							>> .\configs\xst.conf
::echo -iuc NO								>> .\configs\xst.conf
::echo -keep_hierarchy no					>> .\configs\xst.conf
::echo -netlist_hierarchy as_optimized		>> .\configs\xst.conf
::echo -rtlview Yes							>> .\configs\xst.conf
::echo -glob_opt AllClockNets				>> .\configs\xst.conf
::echo -read_cores YES						>> .\configs\xst.conf
::echo -write_timing_constraints NO			>> .\configs\xst.conf
::echo -cross_clock_analysis NO				>> .\configs\xst.conf
::echo -hierarchy_separator /				>> .\configs\xst.conf
::echo -bus_delimiter ^<^>					>> .\configs\xst.conf
::echo -case maintain						>> .\configs\xst.conf
::echo -slice_utilization_ratio 100			>> .\configs\xst.conf
::echo -bram_utilization_ratio 100			>> .\configs\xst.conf
::echo -dsp_utilization_ratio 100			>> .\configs\xst.conf
::echo -fsm_extract YES						>> .\configs\xst.conf
::echo -fsm_encoding Auto					>> .\configs\xst.conf
::echo -safe_implementation Yes				>> .\configs\xst.conf
::echo -fsm_style lut						>> .\configs\xst.conf
::echo -ram_extract Yes						>> .\configs\xst.conf
::echo -ram_style Auto						>> .\configs\xst.conf
::echo -rom_extract Yes						>> .\configs\xst.conf
::echo -mux_style Auto						>> .\configs\xst.conf
::echo -decoder_extract YES					>> .\configs\xst.conf
::echo -priority_extract YES				>> .\configs\xst.conf
::echo -shreg_extract YES					>> .\configs\xst.conf
::echo -shift_extract YES					>> .\configs\xst.conf
::echo -xor_collapse YES					>> .\configs\xst.conf
::echo -rom_style Auto						>> .\configs\xst.conf
::echo -auto_bram_packing NO				>> .\configs\xst.conf
::echo -mux_extract YES						>> .\configs\xst.conf
::echo -resource_sharing YES				>> .\configs\xst.conf
::echo -async_to_sync NO					>> .\configs\xst.conf
::echo -use_dsp48 auto						>> .\configs\xst.conf
::echo -iobuf YES							>> .\configs\xst.conf
::echo -max_fanout 20						>> .\configs\xst.conf
::echo -bufg 32								>> .\configs\xst.conf
::echo -bufr 40								>> .\configs\xst.conf
::echo -register_duplication YES			>> .\configs\xst.conf
::echo -register_balancing No				>> .\configs\xst.conf
::echo -slice_packing YES					>> .\configs\xst.conf
::echo -optimize_primitives yes				>> .\configs\xst.conf
::echo -use_clock_enable Auto				>> .\configs\xst.conf
::echo -slice_utilization_ratio_maxmargin 5	>> .\configs\xst.conf

::******************************************************************************
:: CORE INSERTER ARGS **********************************************************
::******************************************************************************

::set inserterargs=-create coreinserter\%nomeprojeto%.cdc
set inserterargs=-edit coreinserter\%nomeprojeto%.cdc -ngcbuild -p %device% -dd coreinserter -i ..\xst\%nomeprojeto%.ngc ..\xst\%nomeprojeto%.ngc

::******************************************************************************
:: NGDBUILD ARGS ***************************************************************
::******************************************************************************

:: NGDBuild Manual
:: http://toolbox.xilinx.com/docsan/xilinx4/data/docs/dev/ngdbuild.html

:: NGDBuild Options
:: http://toolbox.xilinx.com/docsan/xilinx4/data/docs/dev/ngdbuild7.html

echo -intstyle xflow								 > .\configs\ngd.conf
echo -dd . 											>> .\configs\ngd.conf
echo -uc %ucfile%									>> .\configs\ngd.conf
echo -verbose										>> .\configs\ngd.conf
echo ..\xst\%nomeprojeto%.ngc %nomeprojeto%.ngd		>> .\configs\ngd.conf

::******************************************************************************
:: MAP ARGS ********************************************************************
::******************************************************************************

:: MAP Manual
:: http://toolbox.xilinx.com/docsan/xilinx7/books/data/docs/dev/dev0065_12.html

:: MAP Options
:: http://toolbox.xilinx.com/docsan/xilinx4/data/docs/dev/map6.html

echo -intstyle xflow					 > .\configs\map.conf
echo -p %device%						>> .\configs\map.conf
echo -bp								>> .\configs\map.conf
echo -timing							>> .\configs\map.conf
echo -logic_opt on						>> .\configs\map.conf
echo -ol high							>> .\configs\map.conf
echo -xe c								>> .\configs\map.conf
echo -t 1								>> .\configs\map.conf
echo -register_duplication				>> .\configs\map.conf
echo -global_opt on						>> .\configs\map.conf
echo -retiming on						>> .\configs\map.conf
echo -equivalent_register_removal on	>> .\configs\map.conf
echo -cm speed							>> .\configs\map.conf
echo -ignore_keep_hierarchy				>> .\configs\map.conf
echo -pr off							>> .\configs\map.conf
echo -power off							>> .\configs\map.conf
echo -o %nomeprojeto%.ncd ..\ngd\%nomeprojeto%.ngd %nomeprojeto%.pcf	>> .\configs\map.conf

::******************************************************************************
:: PAR ARGS ********************************************************************
::******************************************************************************

:: PAR Manual
:: http://toolbox.xilinx.com/docsan/xilinx7/books/data/docs/dev/dev0087_14.html

:: PAR Options
:: http://toolbox.xilinx.com/docsan/xilinx7/books/data/docs/dev/dev0092_14.html

echo -intstyle xflow								 > .\configs\par.conf
echo -pl high										>> .\configs\par.conf
echo -rl high										>> .\configs\par.conf
echo -power on										>> .\configs\par.conf
::echo -xe n										>> .\configs\par.conf
echo -x ..\map\%nomeprojeto%.ncd %nomeprojeto%.ncd	>> .\configs\par.conf

::******************************************************************************
:: TRCE ARGS *******************************************************************
::******************************************************************************

:: Link para referencia das opcoes do trce
:: http://toolbox.xilinx.com/docsan/xilinx7/books/data/docs/dev/dev0119_17.html

echo -intstyle xflow			 > .\configs\trce.conf
echo -e 3 						>> .\configs\trce.conf
echo -s 11						>> .\configs\trce.conf
echo ..\par\%nomeprojeto%.ncd 	>> .\configs\trce.conf

::******************************************************************************
:: NETGEN ARGS *****************************************************************
::******************************************************************************

:: Link para referencia das opcoes do netgen
:: http://toolbox.xilinx.com/docsan/xilinx8/books/data/docs/dev/dev0184_27.html

set netgenargs=-dir . -ofmt verilog ..\par\%nomeprojeto%.ncd

::******************************************************************************
:: BITGEN ARGS *****************************************************************
::******************************************************************************

:: Link para referencia das opcoes do bitgen
:: http://toolbox.xilinx.com/docsan/xilinx4/data/docs/dev/bitgen.html

echo -intstyle xflow						 > .\configs\bitgen.conf
REM echo -g CRC:Enable							>> .\configs\bitgen.conf
REM echo -g DebugBitstream:No					>> .\configs\bitgen.conf
REM echo -g ConfigRate:4						>> .\configs\bitgen.conf
REM echo -g StartUpClk:CClk						>> .\configs\bitgen.conf
REM echo -g CclkPin:PullUp						>> .\configs\bitgen.conf
REM echo -g DonePin:PullUp						>> .\configs\bitgen.conf
REM echo -g M0Pin:PullUp						>> .\configs\bitgen.conf
REM echo -g M1Pin:PullUp						>> .\configs\bitgen.conf
REM echo -g M2Pin:PullUp						>> .\configs\bitgen.conf
REM echo -g ProgPin:PullUp						>> .\configs\bitgen.conf
REM echo -g InitPin:Pullup						>> .\configs\bitgen.conf
REM echo -g CsPin:Pullup						>> .\configs\bitgen.conf
REM echo -g DinPin:Pullup						>> .\configs\bitgen.conf
REM echo -g BusyPin:Pullup						>> .\configs\bitgen.conf
REM echo -g RdWrPin:Pullup						>> .\configs\bitgen.conf
REM echo -g TckPin:PullUp						>> .\configs\bitgen.conf
REM echo -g TdiPin:PullUp						>> .\configs\bitgen.conf
REM echo -g TdoPin:PullUp						>> .\configs\bitgen.conf
REM echo -g TmsPin:PullUp						>> .\configs\bitgen.conf
REM echo -g UnusedPin:PullDown					>> .\configs\bitgen.conf
REM echo -g GWE_cycle:6							>> .\configs\bitgen.conf
REM echo -g GTS_cycle:5  						>> .\configs\bitgen.conf
REM echo -g LCK_cycle:NoWait					>> .\configs\bitgen.conf
REM echo -g Match_cycle:Auto					>> .\configs\bitgen.conf
REM echo -g DONE_cycle:4						>> .\configs\bitgen.conf
REM echo -g DriveDone:No						>> .\configs\bitgen.conf
REM echo -g DonePipe:No							>> .\configs\bitgen.conf
REM echo -g Security:None						>> .\configs\bitgen.conf
REM echo -g UserID:0xFFFFFFFF					>> .\configs\bitgen.conf
REM echo -g Encrypt:No  						>> .\configs\bitgen.conf
REM echo -g DCIUpdateMode:AsRequired			>> .\configs\bitgen.conf
REM echo -g Binary:no							>> .\configs\bitgen.conf
echo ..\par\%nomeprojeto%.ncd				>> .\configs\bitgen.conf
echo .\%nomeprojeto%.bit 					>> .\configs\bitgen.conf

::##############################################################################
::##############################################################################
::##############################################################################
::##############################################################################
::
::                          NAO MEXER DAQUI PRA BAIXO
::
::##############################################################################
::##############################################################################
::##############################################################################
::##############################################################################
::##############################################################################
::##############################################################################
::
:: FLUXO DE PROTOTIPACAO (Atencao, nao mexer daqui para baixo)
::
:: XST
:: CORE INSERTER
:: NGDBUILD
:: MAP
:: PAR
:: TRCE
:: NETGEN
:: BITGEN
::
::##############################################################################

cls
echo.
echo    -------------------------------------------------------
echo    -------------------------------------------------------
echo          .d8888b.         d8888 8888888b.  888    888 
echo         d88P  Y88b       d88888 888   Y88b 888    888 
echo         888    888      d88P888 888    888 888    888 
echo         888            d88P 888 888   d88P 8888888888 
echo         888  88888    d88P  888 8888888P"  888    888 
echo         888    888   d88P   888 888        888    888 
echo         Y88b  d88P  d8888888888 888        888    888 
echo          "Y8888P88 d88P     888 888        888    888 
echo    -------------------------------------------------------
echo                        PROJETO %nomeprojeto%
echo    -------------------------------------------------------
echo             SCRIPT PARA AUTOMACAO DA PROTOTIPACAO
echo    -------------------------------------------------------
echo.
echo    [1] Limpar arquivos/diretorios gerados
echo    [2] Executar script de sintese
echo.

:OPTION
set /p opcao=   Opcao: 

if "%opcao%"=="1" ( goto LIMPA )
if "%opcao%"=="2" ( goto SINTETIZA )
goto OPTION

::##############################################################################
::##############################################################################

:LIMPA
:: Deleta os diretorios gerados
rmdir /S /Q prototipation
rmdir /S /Q configs
exit

::##############################################################################
::##############################################################################

:SINTETIZA

:: Separa a hora
FOR /f "tokens=1,2 delims=: " %%a IN ('time /t') DO (
	SET hora=%%a:%%b
)
:: Separa a data
FOR /f "tokens=1,2 delims= " %%a IN ('date /t') DO (
	SET data=%%b
)

echo    ^>^> Data: %data%
echo    ^>^> Hora de Inicio: %hora%
echo.
echo    ^>^> Dispositivo: %device%
echo    ^>^> Entidade top: %top%
echo.

:flowchoice
set /p optflow=   Opcao de fluxo: [c] Completo, [d] Detalhado: 
if "%optflow%"=="c" ( goto cflow )
if "%optflow%"=="d" ( goto dflow )
goto flowchoice

:cflow
echo.
echo    Executando fluxo COMPLETO de prototipacao
echo    Diretorio de prototipacao foi completamente limpo

if exist .\prototipation (
	rmdir /Q /S .\prototipation
)
mkdir .\prototipation
echo.

:coreinloop
set /p docorein=   Executar o CoreInserter? (s/n): 
if "%docorein%"=="s" ( goto coresegue )
if "%docorein%"=="n" ( goto coresegue )
goto coreinloop

:coresegue
set doxst=s
set dongd=s
set domap=s
set dopar=s
set dotrce=s
set donetgen=s
set dobitgen=s

goto startproj

:dflow
echo.
echo    Executando fluxo DETALHADO de prototipacao
echo.

if not exist .\prototipation (
	mkdir .\prototipation
)

:lbldoxst
set /p doxst=   Executar o XST?          (s/n): 
if "%doxst%" == "s" ( goto lbdocorei )
if "%doxst%" == "n" ( goto lbdocorei )
goto lbldoxst

:lbdocorei
set /p docorein=   Executar o CoreInserter? (s/n): 
if "%docorein%" == "s" ( goto lbldongd )
if "%docorein%" == "n" ( goto lbldongd )
goto lbdocorei

:lbldongd
set /p dongd=   Executar o NGDBuild?     (s/n): 
if "%dongd%" == "s" ( goto lbldomap )
if "%dongd%" == "n" ( goto lbldomap )
goto lbldongd

:lbldomap
set /p domap=   Executar o MAP?          (s/n): 
if "%dongd%" == "s" ( goto lbldopar )
if "%dongd%" == "n" ( goto lbldopar )
goto lbldomap

:lbldopar
set /p dopar=   Executar o PAR?          (s/n): 
if "%dopar%" == "s" ( goto lbldotrce )
if "%dopar%" == "n" ( goto lbldotrce )
goto lbldopar

:lbldotrce
set /p dotrce=   Executar o TRCE?         (s/n): 
if "%dotrce%" == "s" ( goto lbldonetgen )
if "%dotrce%" == "n" ( goto lbldonetgen )
goto lbldotrce

:lbldonetgen
set /p donetgen=   Executar o NetGen?       (s/n): 
if "%donetgen%" == "s" ( goto lbldobitgen )
if "%donetgen%" == "n" ( goto lbldobitgen )
goto lbldonetgen

:lbldobitgen
set /p dobitgen=   Executar o BitGen?       (s/n): 
if "%dobitgen%" == "s" ( goto startproj )
if "%dobitgen%" == "n" ( goto startproj )
goto lbldobitgen

goto startproj

:startproj
cd .\prototipation

::##############################################################################
:: XST #########################################################################
::##############################################################################

set programa=XST
set defname=xst

if "%doxst%" == "s" (
	echo.
	echo #^> Executando o %programa%...
	if exist %defname% (
		rmdir /q /s %defname%
	)
	mkdir %defname%
	cd %defname%
	xst -ifn ..\..\configs\%defname%.conf > ..\%defname%.log
	if exist ..\%defname%.log (
		for /f "tokens=1,2,3,4,5 delims= " %%a in (..\%defname%.log) do (
			if "%%c" == "errors" (
				::set nerrors=%%e
				if "%%e" == "0" (
					echo    Errors : %%e
					echo    Etapa finalizada com sucesso.
				) else (
					echo    Errors : %%e
					echo    Verifique os arquivos de log.
					echo.
					pause
					exit
				)
			)
		)
	) else (
		echo    Algum problema ocorreu com o %programa%!
		echo    O script sera encerrado
		echo.
		pause
		exit
	)
	cd ..
)

::##############################################################################
:: COREINSERTER ################################################################
::##############################################################################

set programa=CoreInserter
set defname=coreins

if "%docorein%" == "s" (
	echo.
	if not "%inserterargs%" == "" (
		if exist %defname% (
			rmdir /q /s %defname%
		)
		mkdir %defname%
		cd %defname%	
		inserter %inserterargs%
		pause
		echo.		
	)
	cd ..	
)

::##############################################################################
:: NGDBUILD ####################################################################
::##############################################################################

set programa=NGDBuild
set defname=ngd

if "%dongd%" == "s" (
	echo.
	echo #^> Executando o %programa%...
	if exist %defname% (
		rmdir /q /s %defname%
	)
	mkdir %defname%
	cd %defname%
	::
	if not "%ngclist%" == "" ( copy /y %ngclist% . )
	ngdbuild -f ..\..\configs\%defname%.conf > ..\%defname%.log
	::
	if exist ..\%defname%.log (
		for /f "tokens=1,2,3,4,5 delims= " %%a in (..\%defname%.log) do (
			if "%%c" == "errors:" (
				::set nerrors=%%d
				if "%%d" == "0" (
					echo    Errors : %%d
					echo    Etapa finalizada com sucesso.
				) else (
					echo    Errors : %%d
					echo    Verifique os arquivos de log.
					echo.
					pause
					exit
				)
			)
		)
	) else (
		echo    Algum problema ocorreu com o %programa%!
		echo    O script sera encerrado
		echo.
		pause
		exit
	)
	cd ..
)

::##############################################################################
:: MAP #########################################################################
::##############################################################################

set programa=MAP
set defname=map

if "%domap%" == "s" (
	echo.
	echo #^> Executando o %programa%...
	if exist %defname% (
		rmdir /q /s %defname%
	)
	mkdir %defname%
	cd %defname%
	::
	map -f ..\..\configs\%defname%.conf > ..\%defname%.log
	::
	if exist ..\%defname%.log (
		for /f "tokens=1,2,3,4,5 delims= " %%a in (..\%defname%.log) do (
			if "%%c" == "errors:" (
				set nerrors=%%d
				if "%%d" == "0" (
					echo    Errors : %%d
					echo    Etapa finalizada com sucesso.
				) else (
					echo    Errors : %%d
					echo    Verifique os arquivos de log.
					echo.
					pause
					exit
				)
			)
			if "%%c" == "errors" (
				set nerrors=%%e
				if "%%e" == "0" (
					echo    Errors : %%e
					echo    Etapa finalizada com sucesso.
				) else (
					echo    Errors : %%e
					echo    Verifique os arquivos de log.
					echo.
					pause
					exit
				)
			)
		)
	) else (
		echo    Algum problema ocorreu com o %programa%!
		echo    O script sera encerrado
		echo.
		pause
		exit
	)
	cd ..
)

::##############################################################################
:: PAR #########################################################################
::##############################################################################

set programa=PAR
set defname=par

if "%dopar%" == "s" (
	echo.
	echo #^> Executando o %programa%...
	if exist %defname% (
		rmdir /q /s %defname%
	)
	mkdir %defname%
	cd %defname%
	::
	par -f ..\..\configs\%defname%.conf > ..\%defname%.log
	::
	if exist ..\%defname%.log (
		for /f "tokens=1,2,3,4,5 delims= " %%a in (..\%defname%.log) do (
			if "%%c" == "error" (
				set nerrors=%%e
				if "%%e" == "0" (
					echo    Errors : %%e
					echo    Etapa finalizada com sucesso.
				) else (
					echo    Errors : %%e
					echo    Verifique os arquivos de log.
					echo.
					pause
					exit
				)
			)
		)
	) else (
		echo    Algum problema ocorreu com o %programa%!
		echo    O script sera encerrado
		echo.
		pause
		exit
	)
	cd ..
)

::##############################################################################
:: TRCE ########################################################################
::##############################################################################

set programa=TRCE
set defname=trce

if "%dotrce%" == "s" (
	echo.
	echo #^> Executando o %programa%...
	if exist %defname% (
		rmdir /q /s %defname%
	)
	mkdir %defname%
	cd %defname%
	::
	trce -f ..\..\configs\%defname%.conf > ..\%defname%.log
	::
	if exist ..\%defname%.log (
		for /f "tokens=1,2,3,4,5 delims= " %%a in (..\%defname%.log) do (
			if "%%c" == "errors" (
				set nerrors=%%d
				if not "%%d" == "0" (
					echo    Errors : %%d
					echo    Verifique os arquivos de log.
					echo.
					pause
					exit
				)
			)
		)
		echo    Errors : 0
		echo    Etapa finalizada com sucesso.
	) else (
		echo    Algum problema ocorreu com o %programa%!
		echo    O script sera encerrado
		echo.
		pause
		exit
	)
	cd ..
)

::##############################################################################
:: NETGEN ######################################################################
::##############################################################################

set programa=NetGen
set defname=netgen

if "%donetgen%" == "s" (
	echo.
	echo #^> Executando o %programa%...
	if exist %defname% (
		rmdir /q /s %defname%
	)
	mkdir %defname%
	cd %defname%
	::
	netgen %netgenargs% > ..\%defname%.log
	::
	if exist ..\%defname%.log (
		for /f "tokens=1,2,3,4,5 delims= " %%a in (..\%defname%.log) do (
			if "%%c" == "errors" (
				set nerrors=%%d
				if not "%%d" == "0" (
					echo    Errors : %%d
					echo    Verifique os arquivos de log.
					echo.
					pause
					exit
				)
			)
		)
		echo    Errors : 0
		echo    Etapa finalizada com sucesso.
	) else (
		echo    Algum problema ocorreu com o %programa%!
		echo    O script sera encerrado
		echo.
		pause
		exit
	)
	cd ..
)

::##############################################################################
:: BITGEN ######################################################################
::##############################################################################

set programa=BitGen
set defname=bitgen

if "%dobitgen%" == "s" (
	echo.
	echo #^> Executando o %programa%...
	if exist %defname% (
		rmdir /q /s %defname%
	)
	mkdir %defname%
	cd %defname%
	::
	bitgen -f ..\..\configs\%defname%.conf > ..\%defname%.log
	::
	if exist ..\%defname%.log (
		for /f "tokens=1,2,3,4,5,6 delims= " %%a in (..\%defname%.log) do (
			if "%%f" == "errors" (
				set nerrors=%%e
				if not "%%e" == "0" (
					echo    Errors : %%e
					echo    Verifique os arquivos de log.
					echo.
					pause
					exit
				)
			)
		)
		echo    Errors : 0
		echo    Etapa finalizada com sucesso.
	) else (
		echo    Algum problema ocorreu com o %programa%!
		echo    O script sera encerrado
		echo.
		pause
		exit
	)
	cd ..
)

::##############################################################################
::##############################################################################
::##############################################################################

:: Separa a hora
FOR /f "tokens=1,2 delims=: " %%a IN ('time /t') DO (
	SET hora=%%a:%%b
)

echo.
echo    ^>^> Execucao Terminada!
echo    ^>^> Hora de Termino: %hora%
echo.

if exist .\configs (
	rmdir /q /s .\configs
)

echo.
echo.
pause