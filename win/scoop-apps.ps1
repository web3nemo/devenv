param
(
    [string] $csv = "scoop-apps.csv",
    [string] $settings = "settings/"
)

$root = split-path -parent $MyInvocation.MyCommand.Definition
$path = Join-Path -Path $root -ChildPath $settings
$apps = Get-Item -Path $path\$csv | Get-Content -Encoding utf8
$apps | ForEach-Object {
    # 忽略空行、#开始的注释行
    If( ( -Not [String]::IsNullOrEmpty($_) ) -and ( -Not $_.StartsWith("#") ) )
    {
        # 忽略行尾内嵌注释
        $_ = $_ -replace '\s+#.*$'
        scoop install $_
    }
}

# 列出所有的scoop应用
scoop list
