::---------------------------------------------------------------------------
::---------------------------------------------------------------------------
::				 .d8888b.         d8888 8888888b.  888    888 
::				d88P  Y88b       d88888 888   Y88b 888    888 
::				888    888      d88P888 888    888 888    888 
::				888            d88P 888 888   d88P 8888888888 
::				888  88888    d88P  888 8888888P"  888    888 
::				888    888   d88P   888 888        888    888 
::				Y88b  d88P  d8888888888 888        888    888 
::				 "Y8888P88 d88P     888 888        888    888 
::---------------------------------------------------------------------------
::---------------------------------------------------------------------------
:: Title		: SCRIPT PARA AUTOMAÇÃO DAS SIMULAÇÕES
:: Project		: X10GIGA
::---------------------------------------------------------------------------
:: File			: simula.bat
:: Author(s)	: Leandro Sehnem Heck
::				  Jeferson Camargo de Oliveira
:: Company		: GAPH - Hardware Design Support Group
:: Created		: 2008-08-27
:: Last update	: 2008-10-15
:: Platform		: X10GIGA
:: Standard		: VHDL'93
::---------------------------------------------------------------------------
:: Description: 
::---------------------------------------------------------------------------
:: Copyright(c)2008
::---------------------------------------------------------------------------
:: Revisions  :
:: Date			Version		Author			Description
:: 2008-08-27	1.0			Leandro			Created
:: 2008-10-15	1.0			Jeferson		Modificado para o extrator
::---------------------------------------------------------------------------

@echo off
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
echo                        PROJETO X10GiGA
echo    -------------------------------------------------------
echo             SCRIPT PARA AUTOMACAO DAS SIMULACOES
echo    -------------------------------------------------------
echo.
echo    [1] Limpar arquivos/diretorios gerados
echo    [2] Executar script de simulacao
echo.

:OPTION
set /p opcao=   Opcao: 

if "%opcao%"=="1" ( goto LIMPA )
if "%opcao%"=="2" ( goto SIMULA )
goto OPTION

::##########################################################

:LIMPA
:: Deleta os arquivos gerados
del /F /Q *.ini
del /F /Q *.wlf
del /F /Q transcript

:: Deleta os diretorios gerados
rmdir /S /Q work

goto FIM

::##########################################################

:SIMULA

echo.
echo    O diretorio contem os seguintes scripts:
echo.
:: Exibe todos os arquivos .DO .TCL .TK na tela para que o usuario selecione qual ele quer executar.
for %%a in (*.do) do (
	echo    ^>^> %%a
)
echo.

:GETFILE
set /p filename=   Digite o script para simular: 
if exist %filename% (
	goto FILEOK
) else (
	echo    Erro, script inexistente!
	goto GETFILE
)

:FILEOK

:: Seta os diversos (e exaustivos, diga-se de passagem) tipos de modelsim que existem no laboratorio
if exist C:\Modeltech_6.1f\win32\NUL ( set PATH=.;C:\Modeltech_6.1f\win32; )
if exist C:\Modeltech_6.3c\win32\NUL ( set PATH=.;C:\Modeltech_6.3c\win32; )
if exist C:\Modeltech_6.3d\win32\NUL ( set PATH=.;C:\Modeltech_6.3d\win32; )
if exist C:\Modeltech\win32\NUL ( set PATH=.;C:\Modeltech\win32; )

modelsim -do .\%filename%	

:FIM