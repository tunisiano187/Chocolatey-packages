$ErrorActionPreference = 'Stop';
$packageName    = $env:ChocolateyPackageName
$SilentArgs     = "$silentArgs"
$url            = 'https://github.com/enzo1982/freac/releases/download/v1.1.7/freac-1.1.7-windows-i686.zip'
$checksum       = 'a4ab14999dffe88b5ec6330f8e6444a3a12eb10ec0373759514ba89ab4bcd3fd'
$ChecksumType   = 'sha256'
$url64          = 'https://github.com/enzo1982/freac/releases/download/v1.1.7/freac-1.1.7-windows-x64.zip'
$checksum64     = 'ef45665aae6c1c0eb4c0ecd8ecc6bed24f02f3cddf6cfd72d8e5c9bc858bf110'
$ChecksumType64 = 'sha256'

$packageArgs = @{
    PackageName     = $packageName
    Url             = $url
    Checksum        = $checksum
    ChecksumType    = $ChecksumType
    Url64           = $url64
    Checksum64      = $checksum64
    ChecksumType64  = $ChecksumType64
    SilentArgs      = $silentArgs
}

# Download and unzip into a temp folder
Install-ChocolateyZipPackage @packageArgs
