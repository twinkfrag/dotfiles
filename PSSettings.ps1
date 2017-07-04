using namespace System.IO;

Set-ExecutionPolicy RemoteSigned

$dir = New-Object DirectoryInfo(Split-Path -Parent $MyInvocation.MyCommand.Definition)

New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Console\TrueTypeFont' -Name 932.1 -PropertyType String -Value "Consolas"
New-ItemProperty -Path 'HKCU:\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe\' -Name FontFamily -PropertyType String -Value "Consolas"

$psProfile = $dir.GetFiles("Microsoft.PowerShell_profile.ps1")
$psiseProfile = $dir.GetFiles("Microsoft.PowerShellISE_profile.ps1")
PowerShell -File $targetProfile

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
if (![Directory]::Exists([Path]::Combine($env:APPDATA, "Code"))) 
{
    [Directory]::CreateDirectory([Path]::Combine($env:APPDATA, "Code"))
}
New-Item (New-Object DirectoryInfo([Path]::Combine($env:APPDATA, "Code\\User"))) -Value $dir.GetDirectories("VSCodeUserSettings").FullName -ItemType SymbolicLink
New-Item (New-Object FileInfo([Path]::Combine($env:APPDATA, "ConEmu.xml"))) -Value $dir.GetFiles("ConEmu.xml").FullName -ItemType SymbolicLink
Copy-Item -Path $dir.GetFiles(".gitconfig").FullName -Destination $env:USERPROFILE

(New-Object DirectoryInfo(([Path]::Combine($env:LOCALAPPDATA, "vim")))).Create()

#Set-NetConnectionProfile -NetworkCategory Private
#Enable-PSRemoting

Pause
