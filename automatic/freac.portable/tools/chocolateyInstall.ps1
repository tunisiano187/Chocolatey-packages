$ErrorActionPreference = 'Stop';
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/enzo1982/freac/releases/download/v1.1.3/freac-1.1.3-windows.zip'
$checksum       = 'e325ce353515ebd86c4b124964ba54d1510fd1e9675e19eed90e460ad002bcab'
$ChecksumType   = 'sha256'
$url64          = 'https://github.com/enzo1982/freac/releases/download/v1.1.3/freac-1.1.3-windows-x64.zip'
$checksum64     = '585d29c3edba3611582969f3ebe2bd7f5c853990ecdacbda3bab6d2f0a4459e3'
$ChecksumType64 = 'sha256'

$packageArgs = @{
    PackageName     = $packageName
    Url             = $url
    Checksum        = $checksum
    ChecksumType    = $ChecksumType
    Url64           = $url64
    Checksum64      = $chcksum64
    ChecksumType64  = $ChecksumType64
    UnzipLocation   = $toolsDir
}

# Download and unzip into a temp folder
Install-ChocolateyZipPackage @packageArgs
