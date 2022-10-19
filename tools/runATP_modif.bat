@echo off
set "desbloq_name=%1_DESBLOQ.ATP"
copy %1 %desbloq_name%
rem pause
rem Find_And_Replace.vbs %desbloq_name% "IF (t <= timestep) THEN" "IF ((RG_PC = 0.0) OR (t <= timestep)) THEN"
Find_And_Replace.vbs %desbloq_name% "DELAY CELLS DFLT: 1000" "DELAY CELLS DFLT: 50000"
MOVE /Y %desbloq_name% %1
REM BatchSubstitute.bat "IF (t <= timestep) THEN" "IF ((RG_PC = 0.0) OR (t <= timestep)) THEN" %1
C:\ATP\tools\runATP.exe %1
