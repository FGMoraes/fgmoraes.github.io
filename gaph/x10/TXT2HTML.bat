:: Gerador do HTML

@echo off
cls

::##############################################################################
::##############################################################################

:: Define algumas variaveis
set textfile=index.t2t
set htmlfile=index.html

::##############################################################################
::##############################################################################

if exist %htmfile% ( del /f /q %htmfile% )

echo.
echo Gerando a pagina... 

:: Seta o caminho do programa TEXT2TAGS
set PATH=.;C:\Program Files\txt2tags

:: Chama o TEXT2TAGS com argumentos em arquivo
txt2tags --outfile=%htmlfile% %textfile%

::##############################################################################
::##############################################################################

echo Feito acabou!