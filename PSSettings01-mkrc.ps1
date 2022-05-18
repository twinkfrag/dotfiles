using namespace System.IO;

$dir = New-Object DirectoryInfo(Split-Path -Parent $MyInvocation.MyCommand.Definition)

$linkFilenames = @(
    ".vimrc", ".gvimrc", ".vim-tyny.vimrc",
    ".gitignore", ".git.gitconfig", 
    ".latexmkrc", 
    ".bashrc", ".bash.bashrc", ".bash_history",
    ".editorconfig"
)
foreach ($name in $linkFilenames)
{
    New-Item (New-Object FileInfo([Path]::Combine($env:USERPROFILE, $name))) -Value $dir.GetFiles($name).FullName -ItemType SymbolicLink
}
New-Item (New-Object DirectoryInfo([Path]::Combine($env:USERPROFILE, ".ssh"))) -Value $dir.Parent.GetDirectories(".ssh").FullName -ItemType SymbolicLink

Copy-Item -Path $dir.GetFiles(".gitconfig").FullName -Destination $env:USERPROFILE

(New-Object DirectoryInfo(([Path]::Combine($env:LOCALAPPDATA, "vim")))).Create()

Pause
