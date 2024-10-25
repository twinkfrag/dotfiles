using namespace System.IO;

$dir = New-Object DirectoryInfo(Split-Path -Parent $MyInvocation.MyCommand.Definition)

$linkFilenames = @(
    ".vimrc", ".gvimrc", ".vim-tiny.vimrc",
    ".gitignore", ".git.gitconfig", 
    ".latexmkrc", 
    ".bashrc", ".bash.bashrc", ".bash_history",
    ".editorconfig",
    ".wslconfig"
)
foreach ($name in $linkFilenames)
{
    New-Item (New-Object FileInfo([Path]::Combine($env:USERPROFILE, $name))) -Value $dir.GetFiles($name).FullName -ItemType SymbolicLink
}
New-Item (New-Object DirectoryInfo([Path]::Combine($env:USERPROFILE, ".ssh"))) -Value $dir.Parent.GetDirectories(".ssh").FullName -ItemType SymbolicLink

Copy-Item -Path $dir.GetFiles(".gitconfig").FullName -Destination $env:USERPROFILE

(New-Object DirectoryInfo(([Path]::Combine($env:LOCALAPPDATA, "vim")))).Create()

# ssh-agent
Set-Service -Name "ssh-agent" -StartupType AutomaticDelayedStart
Start-Service -Name "ssh-agent"
ssh-add "$env:OneDriveConsumer\Projects\.ssh\id_ed25519"
# (1) サーバに pam_ssh_agent_auth をインストール
# ```
# apt install libpam-ssh-agent-auth
# cat <<EOF | sudo tee -a /etc/pam.d/sudo
# auth sufficient pam_ssh_agent_auth.so file=~/.ssh/authorized_keys debug
# EOF
# (2) sshコマンドを `ssh -A` (agentの転送)に変更 or `ForwardAgent yes`

Pause
