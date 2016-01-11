# cmd /c mklink $profile %this%
# Set-ExecutionPolicy RemoteSigned
$window = (Get-Host).UI.RawUI
$window.WindowTitle = "Crown Hears"

Set-Alias Open Invoke-Item

function global:Wait()
{
    Write-Host "Press Any Key..."
    [System.Console]::ReadKey() | Out-Null
}
