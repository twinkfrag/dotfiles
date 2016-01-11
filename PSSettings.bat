echo off
openfiles > NUL 2>&1 
if %ERRORLEVEL% EQU 0 goto Admin 
echo ˆê”ÊŒ ŒÀ‚ÅÀs’†
powershell -Command Start-Process %0 -Verb RunAs
exit
 
:Admin 
echo ŠÇ—ÒŒ ŒÀ‚ÅÀs’†
call powershell -ExecutionPolicy ByPass -File %~dp0PSSettings.ps1
:End
