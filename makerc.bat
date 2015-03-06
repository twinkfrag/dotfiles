echo off
openfiles > NUL 2>&1 
if NOT %ERRORLEVEL% EQU 0 goto NotAdmin 
echo 管理者権限で実行中
mklink %userprofile%\_vimrc %~dp0.vimrc
mklink %userprofile%\_gvimrc %~dp0.gvimrc
mklink %userprofile%\.gitignore %~dp0.gitignore
mklink /d %userprofile%\.git %~dp0.git
pause
goto End
 
:NotAdmin 
echo 一般権限で実行中
call powershell -Command Start-Process %0 -Verb RunAs
:End
