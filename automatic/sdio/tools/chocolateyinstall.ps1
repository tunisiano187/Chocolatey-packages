$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$checksumType   = 'sha256'
$checksum       = '621392f69f2856e97769e7a74bc1fbddce313e48c7bf007f0852db63fb4f9317'
$url            = 'https://www.glenn.delahoy.com/downloads/sdio/SDIO_1.13.4.771.zip'

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
