echo off
openfiles > NUL 2>&1 
if NOT %ERRORLEVEL% EQU 0 goto NotAdmin 
echo 管理者権限で実行中
chdir %~dp0
pwd
mkdir %localappdata%\vim
mklink %userprofile%\.vimrc %~dp0.vimrc
mklink %userprofile%\.gvimrc %~dp0.gvimrc
mklink %userprofile%\.gitignore %~dp0.gitignore
copy .gitconfig %userprofile%\.gitconfig
mklink %userprofile%\.user.gitconfig %~dp0.user.gitconfig
mklink %userprofile%\.vsvimrc %~dp0.vsvimrc
mklink %userprofile%\.latexmkrc %~dp0.latexmkrc
mklink %userprofile%\.bashrc %~dp0.bashrc
mklink %userprofile%\.bash_profile %~dp0.bash_profile
mklink /d %userprofile%\.ssh %~dp0..\.ssh
pause
goto End
 
:NotAdmin 
echo 一般権限で実行中
call powershell -Command Start-Process %0 -Verb RunAs
:End
