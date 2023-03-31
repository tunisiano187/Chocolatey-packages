$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/snes9xgit/snes9x/releases/download/1.62.3/snes9x-1.62.3-win32.zip'
$checksum = '70e520d81e2f92ee77070e3b8c61ffec42e7dee7f49bea40c8ae5e83fa934e66'
$checksumType = 'sha256'
$url64 = 'https://github.com/snes9xgit/snes9x/releases/download/1.62.3/snes9x-1.62.3-win32-x64.zip'
$checksum64 = 'a681e000c2b215878bd55151c8633d24beb423d10b45bb7dcd9e522fbeb4ea2a'
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
