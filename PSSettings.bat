echo off
openfiles > NUL 2>&1 
if NOT %ERRORLEVEL% EQU 0 goto NotAdmin 
echo 管理者権限で実行中
powershell -Command Set-ExecutionPolicy RemoteSigned
call powershell -File %~dp0PSSettings.ps1
pause
goto End
 
:NotAdmin 
echo 一般権限で実行中
call powershell -Command Start-Process %0 -Verb RunAs
:End
