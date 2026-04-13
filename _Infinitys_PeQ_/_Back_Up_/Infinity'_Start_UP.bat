@echo off
title Infinitys_PeQ Portable Server Launcher
cd /d "%~dp0"
color 0B

:menu
cls
echo.
echo ==============================================================
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::         I N F I N I T Y s _ P e Q   S E R V E R          ::
echo ::             Portable Master Launcher                    ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ==============================================================
echo.
echo  1) Start Apache (with crash protection)
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
echo.
echo Public Mode ENABLED. Config file updated.
pause
goto menu

:disablepublic
echo OFF>Infinity_Public_Mode.txt
echo.
echo Public Mode DISABLED. Config file updated.
pause
goto menu

:showmode
set PUBLIC_MODE=OFF
if exist "Infinity_Public_Mode.txt" (
    for /f "usebackq tokens=1" %%A in ("Infinity_Public_Mode.txt") do (
        set PUBLIC_MODE=%%A
    )
)
echo.
echo Current Mode: %PUBLIC_MODE%
pause
goto menu

:startserver
cls
echo.
echo ==============================================================
echo ::::::::::::::::::  STARTING INFINITY SERVER  ::::::::::::::::
echo ==============================================================
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

REM === Apply Public Mode Firewall Rules if ON ===
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

REM === Check for Portable Perl ===
    echo ERROR: Portable Perl not found!
    echo Expected at: %~dp0perl\bin\perl.exe
    echo.
    echo Make sure you extracted Strawberry Perl portable to: .\perl\
    pause
    goto menu
)

echo Initializing Portable Perl...
set PERL_HOME=%~dp0perl
set PATH=%PERL_HOME%\bin;%PATH%
set PERL5LIB=%PERL_HOME%\lib;%PERL_HOME%\vendor\lib;%PERL_HOME%\site\lib
echo Portable Perl Loaded: %PERL_HOME%
echo.

REM === Start Apache with Crash Protection ===
echo Starting Apache with crash protection...
cd "%~dp0Apache\bin"

:apache_loop
echo.
echo [Apache] Launching...
httpd.exe -k run -f "%~dp0Apache\conf\httpd.conf"

echo.
echo [Apache] Apache stopped or crashed.
echo [%date% %time%] Apache crashed or stopped >> "%~dp0Apache_Crash_Log.txt"
echo Restarting in 3 seconds...
timeout /t 3 >nul
goto 
