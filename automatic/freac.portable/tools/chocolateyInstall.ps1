$ErrorActionPreference = 'Stop';
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/enzo1982/freac/releases/download/v1.1.6/freac-1.1.6-windows-i686.zip'
$checksum       = '1093bf498128b4a87abc3c728d2589b5abbaf224f1e9bd0ef46e6c1a245bb810'
$ChecksumType   = 'sha256'
$url64          = 'https://github.com/enzo1982/freac/releases/download/v1.1.6/freac-1.1.6-windows-i686.zip'
$checksum64     = '1093bf498128b4a87abc3c728d2589b5abbaf224f1e9bd0ef46e6c1a245bb810'
$ChecksumType64 = 'sha256'

$packageArgs = @{
    PackageName     = $packageName
    Url             = $url
    Checksum        = $checksum
    ChecksumType    = $ChecksumType
    Url64           = $url64
    Checksum64      = $checksum64
    ChecksumType64  = $ChecksumType64
    UnzipLocation   = $toolsDir
}

# Download and unzip into a temp folder
Install-ChocolateyZipPackage @packageArgs
