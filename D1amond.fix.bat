@echo off
:: Enable UTF-8 encoding for special characters
chcp 65001 >nul

:: Check for Administrator privileges
net session >nul 2>&1
if not %errorlevel%==0 (
    echo This script requires Administrator privileges. Restarting with elevated rights...
    powershell -Command "Start-Process '%~0' -Verb RunAs"
    exit /b
)

:: Set title and theme
title D1amond.fix MSI Tool
color 5F
mode con: cols=80 lines=25

:: Disable scrolling for
/F "tokens=2 delims=:" %%a in ('mode con') do set "lines=%%a"
mode con: lines=%lines%

:main
cls

:: Display banner
echo.
echo ██████╗  ██╗ █████╗ ███╗   ███╗ ██████╗ ███╗   ██╗██████╗
echo ██╔══██╗███║██╔══██╗████╗ ████║██╔═══██╗████╗  ██║██╔══██╗
echo ██║  ██║╚██║███████║██╔████╔██║██║   ██║██╔██╗ ██║██║  ██║
echo ██║  ██║ ██║██╔══██║██║╚██╔╝██║██║   ██║██║╚██╗██║██║  ██║
echo ██████╔╝ ██║██║  ██║██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██████╔╝
echo ╚═════╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝
echo ------------------------------------------------------------
echo                   Welcome to D1amond.fix
echo            Your ultimate MSI installation fixer
echo ------------------------------------------------------------
echo.
echo [1] Fix MSI Installation Errors
echo [2] Exit
echo.
set /p choice="Select an option (1-2): "

:: Handle user choices
if "%choice%"=="1" goto msi_fix
if "%choice%"=="2" goto exit
goto main

:msi_fix
cls
echo Applying MSI Fix...
echo.

:: Apply permissions for ALL APPLICATION PACKAGES
icacls "C:\Windows\Temp" /grant "ALL APPLICATION PACKAGES:(OI)(CI)F" /T /C >nul 2>&1
if %errorlevel%==0 (
    echo -> Full control granted to ALL APPLICATION PACKAGES.
) else (
    echo -> Failed to apply permissions for ALL APPLICATION PACKAGES.
)

:: Apply permissions for Users
icacls "C:\Windows\Temp" /grant "Users:(OI)(CI)F" /T /C >nul 2>&1
if %errorlevel%==0 (
    echo -> Full control granted to Users.
) else (
    echo -> Failed to apply permissions for Users.
)

echo.
echo MSI Fix applied successfully!

:: Open D1amond.lol website
start https://d1amond.lol

pause >nul
goto main

:exit
cls
echo Thank you for using D1amond.fix!
echo Have a great day!
pause >nul
exit
