echo off
openfiles > NUL 2>&1 
if %ERRORLEVEL% EQU 0 goto Admin 
echo 一般権限で実行中
powershell -Command Start-Process %0 -Verb RunAs
exit
 
:Admin 
echo 管理者権限で実行中
call powershell -ExecutionPolicy ByPass -File %~dp0PSSettings.ps1
:End
