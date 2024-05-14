REM Start a new console windows to execute scoop script for software package installation
@ECHO OFF
cd  %~dp0

START cmd /k powershell -file ./init.ps1