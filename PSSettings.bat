echo off
openfiles > NUL 2>&1 
if NOT %ERRORLEVEL% EQU 0 goto NotAdmin 
echo �Ǘ��Ҍ����Ŏ��s��
powershell -Command Set-ExecutionPolicy RemoteSigned
call powershell -File %~dp0PSSettings.ps1
pause
goto End
 
:NotAdmin 
echo ��ʌ����Ŏ��s��
call powershell -Command Start-Process %0 -Verb RunAs
:End
