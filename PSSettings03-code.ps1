using namespace System.IO;

Write-Host "if you want to set for Code-Insider's setting, press Ctrl+C and edit this file."
Pause

$dir = New-Object DirectoryInfo(Split-Path -Parent $MyInvocation.MyCommand.Definition)

$CodeUserDir = New-Object DirectoryInfo([Path]::Combine($env:APPDATA, "Code\\User"))
$TargetDir = $dir.GetDirectories("VSCodeUserSettings")
if (!$CodeUserDir.Exists) 
{
    $CodeUserDir.Parent.Create()
    $CodeUserDir.Create()
}
Remove-Item [Path]::Combine($CodeUsertDir.FullName, "keybindings.json")
Remove-Item [Path]::Combine($CodeUsertDir.FullName, "locale.json")
Remove-Item [Path]::Combine($CodeUsertDir.FullName, "settings.json")
New-Item [Path]::Combine($CodeUsertDir.FullName, "keybindings.json") -Value [Path]::Combine($TargetDir.FullName, "keybindings.json") -ItemType SymbolicLink
New-Item [Path]::Combine($CodeUsertDir.FullName, "locale.json")      -Value [Path]::Combine($TargetDir.FullName, "locale.json")      -ItemType SymbolicLink
New-Item [Path]::Combine($CodeUsertDir.FullName, "settings.json")    -Value [Path]::Combine($TargetDir.FullName, "settings.json")    -ItemType SymbolicLink

Pause
