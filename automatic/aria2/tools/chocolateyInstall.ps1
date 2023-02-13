$ErrorActionPreference = 'Stop'
$url            = 'https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0-win-32bit-build1.zip'
$checksum       = 'c35a1bfa06726914006888929c6ce147e50b1d9fca8d1dc89bcd2c926f8c16de'
$checksumType   = 'sha256'
$url64          = 'https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0-win-64bit-build1.zip'
$checksum64     = 'c82df5415125b438d72443923fea7f5f9fda1f326d0dbfac6aab16d58dbb7bf0'
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
