using namespace System.IO;

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

$dir = New-Object DirectoryInfo(Split-Path -Parent $MyInvocation.MyCommand.Definition)

$psProfile = $dir.GetFiles("Microsoft.PowerShell_profile.ps1")

$profileInfo = New-Object FileInfo($profile)
$profileInfo.Directory.Create()
New-Item $profileInfo -Value $psProfile.FullName -ItemType SymbolicLink

Pause
