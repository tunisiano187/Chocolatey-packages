$packageName    = 'initool'
$url32          = 'https://github.com/dbohdan/initool/releases/download/v0.15.0/initool-v0.15.0-ea48b1f-win32.zip'
$checksum32     = 'ec052d0cc742967499d609d7317d5f9f46299b9025364f3fc51ed8a358b6a0ad'
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
