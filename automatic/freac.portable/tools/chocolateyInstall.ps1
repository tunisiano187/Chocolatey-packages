$ErrorActionPreference = 'Stop';
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/enzo1982/freac/releases/download/v1.1.3/freac-1.1.3-windows.zip'
$checksum       = ''
$ChecksumType   = ''
$url64          = 'https://github.com/enzo1982/freac/releases/download/v1.1.3/freac-1.1.3-windows-x64.zip'
$checksum64     = ''
$ChecksumType64 = ''

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
