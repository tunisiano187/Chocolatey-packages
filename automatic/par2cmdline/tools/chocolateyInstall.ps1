$url            = 'https://github.com/Parchive/par2cmdline/releases/download/v1.4.0/par2cmdline-1.4.0-win-x64.zip'
$checksum       = '200130143dba1e12f9d1be567d5a446e785d2093e5d735225d8ad0539125b71c'
$checksumType   = 'sha256'
$url64          = 'https://github.com/Parchive/par2cmdline/releases/download/v1.4.0/par2cmdline-1.4.0-win-x64.zip'
$checksum64     = '200130143dba1e12f9d1be567d5a446e785d2093e5d735225d8ad0539125b71c'
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
