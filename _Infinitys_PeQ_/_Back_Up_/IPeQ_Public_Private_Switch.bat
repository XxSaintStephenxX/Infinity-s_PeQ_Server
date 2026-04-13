@echo off
title Infinitys_PeQ Portable Apache Server
cd /d "%~dp0"
color 0B

:menu
cls
echo.
echo ==============================================================
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::         I N F I N I T Y s _ P e Q   S E R V E R          ::
echo ::             Portable Apache Launcher                     ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ==============================================================
echo.
echo  1) Start Server
echo  2) Enable Public Mode
echo  3) Disable Public Mode
echo  4) Show Current Mode
echo  5) Exit
echo.
set /p choice=Select an option: 

if "%choice%"=="1" goto startserver
if "%choice%"=="2" goto enablepublic
if "%choice%"=="3" goto disablepublic
if "%choice%"=="4" goto showmode
if "%choice%"=="5" exit
goto menu

:enablepublic
echo ON>Infinity_Public_Mode.txt
echo Public Mode ENABLED.
pause
goto menu

:disablepublic
echo OFF>Infinity_Public_Mode.txt
echo Public Mode DISABLED.
pause
goto menu

:showmode
set PUBLIC_MODE=OFF
if exist "Infinity_Public_Mode.txt" (
    for /f "usebackq tokens=1" %%A in ("Infinity_Public_Mode.txt") do (
        set PUBLIC_MODE=%%A
    )
)
echo Current Mode: %PUBLIC_MODE%
pause
goto menu

:startserver
cls
echo Starting Infinity Server...
echo.

REM === Read Public Mode Setting ===
set PUBLIC_MODE=OFF
if exist "Infinity_Public_Mode.txt" (
    for /f "usebackq tokens=1" %%A in ("Infinity_Public_Mode.txt") do (
        set PUBLIC_MODE=%%A
    )
)

echo Mode: %PUBLIC_MODE%
echo.

REM === PUBLIC MODE ON ===
if /I "%PUBLIC_MODE%"=="ON" (
    echo Public Mode ENABLED.
    echo Opening required firewall ports...

    netsh advfirewall firewall add rule name="Infinity_EQEmu" dir=in action=allow protocol=TCP localport=5998,5999,7000-7100,9000 >nul 2>&1
    netsh advfirewall firewall add rule name="Infinity_Apache" dir=in action=allow protocol=TCP localport=80 >nul 2>&1

    echo.
    echo Firewall rules added.
    echo.
    echo IMPORTANT: Forward these ports on your router:
    echo   TCP 5998
    echo   TCP 5999
    echo   TCP 7000-7100
    echo   TCP 9000
    echo   TCP 80  (optional for website)
    echo.
    echo Your public IP is:
    curl ifconfig.me
    echo.
) else (
    echo Public Mode DISABLED.
    echo Running in private LAN-only mode.
    echo.
)

echo Starting Apache...
cd Apache\bin
httpd.exe -k run -f "%~dp0Apache\conf\httpd.conf"

echo.
echo Apache has stopped.
pause
goto menu