echo off
openfiles > NUL 2>&1 
if NOT %ERRORLEVEL% EQU 0 goto NotAdmin 
echo �Ǘ��Ҍ����Ŏ��s��
mkdir %localappdata%\vim
mklink %userprofile%\_vimrc %~dp0.vimrc
mklink %userprofile%\_gvimrc %~dp0.gvimrc
mklink %userprofile%\.gitignore %~dp0.gitignore
mklink %userprofile%\.gitconfig %~dp0.gitconfig
pause
goto End
 
:NotAdmin 
echo ��ʌ����Ŏ��s��
call powershell -Command Start-Process %0 -Verb RunAs
:End
