$packageName    = 'initool'
$url32          = 'https://github.com/dbohdan/initool/releases/download/v0.14.0/initool-v0.14.0-ac4b61e-win32.zip'
$checksum32     = 'd9a0d691ae34d186745d311dce87b726c1414117f530339453a901c3d74295c0'
$checksumType32 = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    fileType      = 'ZIP'
    url           = $url32
    checksum      = $checksum32
    checksumType  = $checksumType32
}

Install-ChocolateyZipPackage @packageArgs
