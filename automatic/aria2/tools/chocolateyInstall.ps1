$ErrorActionPreference = 'Stop'
$url            = 'https://github.com/aria2/aria2/releases/download/release-1.37.0/aria2-1.37.0-win-32bit-build1.zip'
$checksum       = '35f6514cc5dd7e98a87b3c4c2d25a0754b9b063dbe59bc0f22d483464f61e5b6'
$checksumType   = 'sha256'
$url64          = 'https://github.com/aria2/aria2/releases/download/release-1.37.0/aria2-1.37.0-win-64bit-build1.zip'
$checksum64     = '67d015301eef0b612191212d564c5bb0a14b5b9c4796b76454276a4d28d9b288'
$checksumType64 = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    UnzipLocation   = $toolsDir
    Url             = $url
    checksum        = $checksum
    checksumType    = $checksumType
    Url64           = $url64
    checksum64      = $checksum64
    checksumType64  = $checksumType64
}

Install-ChocolateyZipPackage @packageArgs
