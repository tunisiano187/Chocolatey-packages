$packageName    = 'initool'
$url32          = 'https://github.com/dbohdan/initool/releases/download/v0.10.1/initool-v0.10.1-b5f23f8-win32.zip'
$checksum32     = '6e1c878e2c8311e7730e04bda40a6370bfe29a36b9515b88bcbce78d437455d3'
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
