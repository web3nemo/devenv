Set-ExecutionPolicy RemoteSigned -scope CurrentUser

$root = split-path -parent $MyInvocation.MyCommand.Definition

# Welcome
& "$root/welcome.ps1"

# Verify that user running script is an administrator
$IsAdmin=[Security.Principal.WindowsIdentity]::GetCurrent()
If ((New-Object Security.Principal.WindowsPrincipal $IsAdmin).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) -eq $FALSE)
{
    Write-Host -ForegroundColor Red "ERROR: You are NOT a local administrator. Run this script after logging on with a local administrator account."
    exit
}

# Install scoop
& "$root/scoop.ps1"
& "$root/scoop-buckets.ps1"
& "$root/scoop-apps.ps1"

# Install vscode extensions
& "$root/scoop-vscode.ps1"
