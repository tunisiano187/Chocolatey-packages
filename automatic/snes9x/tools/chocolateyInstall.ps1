$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/snes9xgit/snes9x/releases/download/1.62.2/snes9x-1.62.2-win32.zip'
$checksum = '8efa03b705499b07e8ecb9d9048981adfa444980079044afb2926df13c0eeaeb'
$checksumType = 'sha256'
$url64 = 'https://github.com/snes9xgit/snes9x/releases/download/1.62.2/snes9x-1.62.2-win32-x64.zip'
$checksum64 = 'fffbe0024b39bdbe59c1f326ff033bbbfe09eef25cf73807033e518c7e095034'
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
