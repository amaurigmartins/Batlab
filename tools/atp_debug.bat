@echo off
set "desbloq_name=%1_DESBLOQ.ATP"
copy %1 %desbloq_name%
del %1
rem move /y %desbloq_name% %1
echo "Este script não executara o solver ATP, podendo ocorrer mensagens de erro no ATPDraw. Ao inves, o arquivo ATP desbloqueado sera aberto para edicao."
pause
notepad %desbloq_name%
