# cmd /c mklink $profile %this%
# Set-ExecutionPolicy RemoteSigned
$window = (Get-Host).UI.RawUI
$window.WindowTitle = "Script Center"

# if(Test-Path Function:\Prompt) {Rename-Item Function:\Prompt PrePoshGitPrompt -Force}
# 
# # Load posh-git example profile
# . 'C:\tools\poshgit\dahlbyk-posh-git-bc8dbd5\profile.example.ps1'
# 
# Rename-Item Function:\Prompt PoshGitPrompt -Force
# function Prompt() {if(Test-Path Function:\PrePoshGitPrompt){++$global:poshScope; New-Item function:\script:Write-host -value "param([object] `$object, `$backgroundColor, `$foregroundColor, [switch] `$nonewline) " -Force | Out-Null;$private:p = PrePoshGitPrompt; if(--$global:poshScope -eq 0) {Remove-Item function:\Write-Host -Force}}PoshGitPrompt}
