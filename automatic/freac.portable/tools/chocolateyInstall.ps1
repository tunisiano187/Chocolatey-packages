$ErrorActionPreference = 'Stop';
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/enzo1982/freac/releases/download/v1.1.4/freac-1.1.4-windows.zip'
$checksum       = '778521d78873193f484cf4a7e8c2c714bad0828759392f0b3cb755d0ee161e4a'
$ChecksumType   = 'sha256'
$url64          = 'https://github.com/enzo1982/freac/releases/download/v1.1.4/freac-1.1.4-windows-x64.zip'
$checksum64     = '24a396daf1fc8115af95ba8ba7bfd71285cf6ab3ce35d26b95699b18665e6996'
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
