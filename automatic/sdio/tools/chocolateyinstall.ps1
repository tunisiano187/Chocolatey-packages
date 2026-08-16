$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$checksumType   = 'sha256'
$checksum       = '2287d171aa15e2f820a51c93e616c1e467bdc05f211982a0eff73eb08d2c6040'
$url            = 'https://www.glenn.delahoy.com/downloads/sdio/SDIO_2.0.2.884.zip'

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
