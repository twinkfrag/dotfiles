echo off
openfiles > NUL 2>&1 
if %ERRORLEVEL% EQU 0 goto Admin 
echo Running As User
powershell -Command Start-Process %0 -Verb RunAs
exit
 
:Admin 
echo Running As Admin
call powershell -ExecutionPolicy ByPass -File %~dp0PSSettings.ps1
:End
