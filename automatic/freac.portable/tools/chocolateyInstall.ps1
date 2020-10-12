$ErrorActionPreference = 'Stop';
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32          = 'https://github.com/enzo1982/freac/releases'
$checksum32     = ''
$ChecksumType32 = ''
$url64          = 'https://github.com/enzo1982/freac/releases'
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