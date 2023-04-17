$Console = (Get-Host).UI.RawUI
$Console.WindowTitle = "Crown Hearts $($PSVersionTable.PSVersion.Major)"

if ((Get-Host).Name.Contains("Code"))
{
    Write-Host "PowerShell v$($PSVersionTable.PSVersion)"
}
if ((Get-Host).Name.Contains("ISE")) 
{
    $Console.WindowTitle += " ISE"
    $psISE.Options.FontSize = 12
}
if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    $Console.WindowTitle += " [Admin]"
}

function Pause
{
    if ($psISE) {
        $null = Read-Host 'Press Enter Key...'
    }
    else {
        Write-Host "Press Any Key..."
        $Console.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    }
}

function Invoke-Command-RunAs
{
    $cd = (Get-Location).Path
    $commands = "Set-Location $cd; Write-Host `"[Administrator] $cd> $args`"; $args; pause; exit"
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($commands)
    $encodedCommand = [Convert]::ToBase64String($bytes)
    Start-Process powershell -Verb RunAs -ArgumentList "-NoExit","-encodedCommand",$encodedCommand
}

function Start-RunAs
{
    $cd = (Get-Location).Path
    $commands = "Set-Location $cd; (Get-Host).UI.RawUI.WindowTitle += `" [Administrator]`""
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($commands)
    $encodedCommand = [Convert]::ToBase64String($bytes)
    Start-Process powershell -Verb RunAs -ArgumentList "-NoExit","-encodedCommand",$encodedCommand
}

function Create-SymbolicLink
{
    # New-Item $profileInfo -Value $psProfile.FullName -ItemType SymbolicLink

}

function Exit-PS {
    Write-Host "Exitting PowerShell..."
    Read-Host
    exit $args
}
 
Set-Alias sudo Invoke-Command-RunAs
Set-Alias su Start-RunAs
Set-Alias Open Invoke-Item
Set-Alias ] Exit-PS
