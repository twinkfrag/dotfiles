echo off
openfiles > NUL 2>&1 
if NOT %ERRORLEVEL% EQU 0 goto NotAdmin 
echo ä«óùé“å†å¿Ç≈é¿çsíÜ
powershell -Command Set-ExecutionPolicy RemoteSigned
call powershell -File %~dp0PSSettings.ps1
pause
goto End
 
:NotAdmin 
echo àÍî å†å¿Ç≈é¿çsíÜ
call powershell -Command Start-Process %0 -Verb RunAs
:End
