param
(
    [string] $csv = "scoop-buckets.csv",
    [string] $settings = "settings/"
)

$root = split-path -parent $MyInvocation.MyCommand.Definition
$path = Join-Path -Path $root -ChildPath $settings
$buckets = Import-Csv $path/$csv -Encoding utf8
$buckets | ForEach-Object {
    If( -Not [String]::IsNullOrEmpty($_) )
    {
        If([String]::IsNullOrEmpty($_.Uri))
        {
            scoop bucket add $_.Name
        }
        Else
        {
            scoop bucket add $_.Name $_.Uri
        }
    }
}
