# Welcome screen
param
(
    [string] $project = "My Workspace",
    [string] $logo = "welcome.txt",
    [string] $settings = "welcome",
    [string] $prompt = "prompt.txt"
)

Set-ExecutionPolicy RemoteSigned -scope CurrentUser

# Logo
$root = split-path -parent $MyInvocation.MyCommand.Definition
$path = Join-Path -Path $root -ChildPath $settings
Get-Item -Path $path\$logo | Get-Content

# Welcome
$alias = $env:UserName
if("$alias" -eq "")
{
    throw("Please set your alias as UserName in environment variables.")
}
Write-Host -ForegroundColor Green "Welcome onboard $project, $alias!"

# Prompt
$candidates = Get-Item -Path $path\$prompt | Get-Content -Delimiter "---" -Encoding utf8
$random = Get-Random -Maximum $candidates.Length
Write-Host -ForegroundColor Green "$($candidates[$random].TrimEnd("---"))"
