param
(
    [string] $csv = "vscode-exts.csv",
    [string] $settings = "settings/"
)

# 如有需要，自动安装vscode
Try
{
    $ver = code --version
}
Catch
{
    scoop install extras/vscode
}

$installed = (code --list-extensions).Split([Environment]::NewLine)
$root = split-path -parent $MyInvocation.MyCommand.Definition
$path = Join-Path -Path $root -ChildPath $settings
$exts = Get-Item -Path $path\$csv | Get-Content -Encoding utf8
$exts | ForEach-Object {
    # 忽略空行、#开始的注释行和已安装的插件（只负责安装从未被安装过的全新插件，不负责升级插件）
    If( ( -Not [String]::IsNullOrEmpty($_) ) -and ( -Not $_.StartsWith("#") ) -and ( -Not ( $installed -Contains $_ ) ) )
    {
        # 忽略行尾内嵌注释
        $_ = $_ -replace '\s+#.*$'
        code --install-extension $_
    }
}

# 更新已安装的vscode插件
code --list-extensions --show-versions | xargs -L 1 echo code --install-extension