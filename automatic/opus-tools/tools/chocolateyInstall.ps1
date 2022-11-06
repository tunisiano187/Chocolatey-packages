$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://archive.mozilla.org/pub/opus/win32/opus-tools-0.2-win32.zip'
$checksum       = '99A7C07C46C24727D9798ADFC53F5D1D82244E3C249476C22DDF0E1D76A7C86C'
$checksumType   = 'sha256'
$url64          = 'https://archive.mozilla.org/pub/opus/win32/opus-tools-0.2-win32.zip'
$checksum64     = '99a7c07c46c24727d9798adfc53f5d1d82244e3c249476c22ddf0e1d76a7c86c'
$checksumType64 = 'sha256'

$packageArgs = @{
    PackageName     = $packageName
    UnzipLocation   = $toolsDir
    Url             = $url
    Checksum        = $checksum
    ChecksumType    = $checksumType
    Url64bit        = $url64
    Checksum64      = $checksum64
    ChecksumType64  = $checksumType64
}

Install-ChocolateyZipPackage @packageArgs
