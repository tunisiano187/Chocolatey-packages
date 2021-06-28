$ErrorActionPreference = 'Stop';
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/enzo1982/freac/releases/download/v1.1.5/freac-1.1.5-windows.zip'
$checksum       = '22aa7ee6e2de1cc61001d63f5472250dc3c6b5026130e7e330b7ba658129d9bc'
$ChecksumType   = 'sha256'
$url64          = 'https://github.com/enzo1982/freac/releases/download/v1.1.5/freac-1.1.5-windows-x64.zip'
$checksum64     = '46fdc6b17035687d0335698017acf25fc9d8c2c9764763c62c82046a7fcef1aa'
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
