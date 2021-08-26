@echo off
rem ---Вспомогательные переменные
set LOG=log.txt
set myprog=myprogramnew
rem ---Путь, имя запускаемой программы и параметры запуска
set Process_Path=C:\Windows\System32\
set Process_Name=tracert.exe
set Process_Param=9.9.9.9
rem ---Запуск программы
start "" /MIN "new.bat" %myprog% %Process_Path% %Process_Name% %Process_Param% %LOG% 
rem ---Основное ядро скрипта
:loop
timeout /t 3
for /F "delims=" %%R in ('
    tasklist /FI "WindowTitle eq %myprog%" /FI "Status eq Running" /FO CSV /NH
') do (
    set "FLAG1=" & set "FLAG2="
    for %%C in (%%R) do (
        if defined FLAG1 (
            if not defined FLAG2 (
				@Set "PID=%%C"
            )
            set "FLAG2=#"
        )
        set "FLAG1=#"
    )
)
if "%PID%"=="No" goto end
echo Program %Process_Name% works with PID %PID%
goto loop
:end
cls
echo Program %Process_Name% has finished work.
echo.
more %LOG%
echo.
pause
exit
