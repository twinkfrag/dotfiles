using namespace System.IO;

Set-ExecutionPolicy RemoteSigned

$dir = New-Object DirectoryInfo(Split-Path -Parent $MyInvocation.MyCommand.Definition)

New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Console\TrueTypeFont' -Name 932.1 -PropertyType String -Value "Consolas"
New-ItemProperty -Path 'HKCU:\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe\' -Name FontFamily -PropertyType String -Value "Consolas"

$psProfile = $dir.GetFiles("Microsoft.PowerShell_profile.ps1")
$psiseProfile = $dir.GetFiles("Microsoft.PowerShellISE_profile.ps1")

$profileInfo = New-Object FileInfo($profile)
$profileInfo.Directory.Create()
New-Item $profileInfo -Value $psProfile.FullName -ItemType SymbolicLink
New-Item (Join-Path $profileInfo.Directory "Microsoft.PowerShellISE_profile.ps1") -Value $psiseProfile.FullName -ItemType SymbolicLink

$linkFilename = @(
    ".vimrc", ".gvimrc", 
    ".gitignore", ".user.gitconfig", 
    ".vsvimrc", 
    ".latexmkrc", 
    ".bashrc", ".bash_profile",
    ".editorconfig"
)
foreach ($name in $linkFilename)
{
    New-Item (New-Object FileInfo([Path]::Combine($env:USERPROFILE, $name))) -Value $dir.GetFiles($name).FullName -ItemType SymbolicLink
}
New-Item (New-Object DirectoryInfo([Path]::Combine($env:USERPROFILE, ".ssh"))) -Value $dir.Parent.GetDirectories(".ssh").FullName -ItemType SymbolicLink

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

Copy-Item -Path $dir.GetFiles(".gitconfig").FullName -Destination $env:USERPROFILE

(New-Object DirectoryInfo(([Path]::Combine($env:LOCALAPPDATA, "vim")))).Create()

#Set-NetConnectionProfile -NetworkCategory Private
#Enable-PSRemoting

Pause
