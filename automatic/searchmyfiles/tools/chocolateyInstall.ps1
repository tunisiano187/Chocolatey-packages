$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file32         = "$(Join-Path $toolsDir -ChildPath 'searchmyfiles.zip')"
$file64         = "$(Join-Path $toolsDir -ChildPath 'searchmyfiles-x64.zip')"
$installFile    = Join-Path $toolsDir "$($env:ChocolateyPackageName).exe"

$unzipArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileFullPath    = $file32
    FileFullPath64  = $file64
    Destination     = $toolsDir
}

Get-ChocolateyUnzip @unzipArgs

Set-Content -Path ("$installFile.gui") `
            -Value $null