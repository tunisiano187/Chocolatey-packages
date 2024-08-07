$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/snes9xgit/snes9x/releases/download/1.63/snes9x-1.63-win32.zip'
$checksum = '71b364acfc9377b3d94bcdd7f7cfafe7f26b94ba44f9024b72adc9d7b9dbf275'
$checksumType = 'sha256'
$url64 = 'https://github.com/snes9xgit/snes9x/releases/download/1.63/snes9x-1.63-win32-x64.zip'
$checksum64 = 'e2bd103819051eae57d163cdbbf6b3b92db73fdd4a6a0ee6a939e507eaa95db8'
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
