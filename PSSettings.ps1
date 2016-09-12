using namespace System.IO;

Set-ExecutionPolicy RemoteSigned

$dir = New-Object DirectoryInfo(Split-Path -Parent $MyInvocation.MyCommand.Definition)

$targetProfile = $dir.GetFiles("Microsoft.PowerShell_profile.ps1")
PowerShell -File $targetProfile

$profileInfo = New-Object FileInfo($profile)
$profileInfo.Directory.Create()
New-Item $profileInfo -Value $targetProfile.FullName -ItemType SymbolicLink

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
New-Item (New-Object DirectoryInfo([Path]::Combine($env:APPDATA, "Code\\User"))) -Value $dir.GetDirectories("VSCodeUserSettings").FullName -ItemType SymbolicLink
New-Item (New-Object FileInfo([Path]::Combine($env:APPDATA, "ConEmu.xml"))) -Value $dir.GetFiles("ConEmu.xml").FullName -ItemType SymbolicLink
Copy-Item -Path $dir.GetFiles(".gitconfig").FullName -Destination $env:USERPROFILE

(New-Object DirectoryInfo(([Path]::Combine($env:LOCALAPPDATA, "vim")))).Create()

#Set-NetConnectionProfile -NetworkCategory Private
#Enable-PSRemoting

function global:Wait()
{
    Write-Host "Press Any Key..."
    [System.Console]::ReadKey() | Out-Null
}

Wait
