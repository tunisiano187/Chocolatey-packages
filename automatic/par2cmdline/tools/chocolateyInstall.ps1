$url            = 'https://github.com/Parchive/par2cmdline/releases/download/v1.1.1/par2cmdline-1.1.1-win-x64.zip'
$checksum       = 'b0d949e2b85759cf1a8a6f9c780cfc2dc8bfe650d379c43bd18e4b7794049409'
$checksumType   = 'sha256'
$url64          = 'https://github.com/Parchive/par2cmdline/releases/download/v1.1.1/par2cmdline-1.1.1-win-x64.zip'
$checksum64     = 'b0d949e2b85759cf1a8a6f9c780cfc2dc8bfe650d379c43bd18e4b7794049409'
$checksumType64 = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'EXE'
    Url           = $url
    Url64bit      = $url64

    UnzipLocation = $toolsDir
    checksum      = $Checksum
    checksumType  = $ChecksumType
    checksum64    = $Checksum64
    checksumType64= $ChecksumType64

}

Install-ChocolateyZipPackage @packageArgs
