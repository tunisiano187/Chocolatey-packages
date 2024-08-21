$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$checksumType   = 'sha256'
$checksum       = '10b01a1aa0bc69b5a75c1def9cedaa9846a5fa421a160afac7ff95cd7a46c083'
$url            = 'https://www.glenn.delahoy.com/downloads/sdio/SDIO_1.13.3.767.zip'

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
