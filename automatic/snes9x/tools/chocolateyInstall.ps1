$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/snes9xgit/snes9x/releases/download/1.62.1/snes9x-1.62.1-win32.zip'
$checksum = 'b13d11a008f91dd2ee50e31c92cf77a533f742ec6e3d927618c1c27bde907f8c'
$checksumType = 'sha256'
$url64 = 'https://github.com/snes9xgit/snes9x/releases/download/1.62.1/snes9x-1.62.1-win32-x64.zip'
$checksum64 = 'f61424a89e4ed60b042e1613590f86481ea7735b4a8d72b4ed69587663f67496'
$checksumType64 = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    fileType      = 'ZIP'
    url           = $url
    checksum      = $checksum
    checksumType  = $checksumType
    Url64bit      = $url64
    checksum64    = $checksum64
    ChecksumType64= $checksumType64
}

Install-ChocolateyZipPackage @packageArgs
