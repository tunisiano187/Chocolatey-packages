$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$checksumType   = 'sha256'
$checksum       = 'ff549430dc543b1eaa978a3643acd9c22eef57641735044a6988b709258c3bf0'
$url            = 'https://www.glenn.delahoy.com/downloads/sdio/SDIO_1.12.21.762.zip'

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
