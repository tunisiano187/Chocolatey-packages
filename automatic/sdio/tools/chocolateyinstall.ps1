$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$checksumType   = 'sha256'
$checksum       = '96f48d84d97ebda6e60fd67c45eaf388ae7d3b3db8e171d3c5d7e5381065ba89'
$url            = 'https://www.glenn.delahoy.com/downloads/sdio/SDIO_2.0.8.891.zip'

$packageArgs = @{
    packageName   = 'sdio'
    unzipLocation = $toolsDir
    fileType      = 'ZIP'
    url           = $url
    checksum      = $checksum
    checksumType  = $checksumType
}

Remove-Item "$ToolsDir\SDIO_*" -Force -Recurse # Cleanup old versions
Install-ChocolateyZipPackage @packageArgs
