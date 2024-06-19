$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$File = "$toolsDir/pinginfoview.zip"
$installFile = Join-Path $toolsDir "$($packageName).exe"

$packageArgs = @{
    FileFullPath    = $File
    UnzipLocation   = $toolsDir
}

Get-ChocolateyUnzip @packageArgs

Set-Content -Path ("$installFile.gui") `
            -Value $null
