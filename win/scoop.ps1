param
(
    [string] $scoop = "c:\scoop"
)

# Update or install scoop
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
Try
{
    scoop update
}
Catch
{
    Write-Host -ForegroundColor Green "Installing scoop to custom directory $scoop..."
    $env:SCOOP=$scoop
    [environment]::setEnvironmentVariable('SCOOP',$env:SCOOP,'User')
    iex "& {$(irm get.scoop.sh)} -RunAsAdmin"
}

# Update installed scoop apps
scoop update *
