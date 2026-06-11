$url            = 'https://github.com/Parchive/par2cmdline/releases/download/v1.2.0/par2cmdline-1.2.0-win-x64.zip'
$checksum       = 'c827065486fcf358fb6e5f1c6178678cf19e501a10be958e621be796da2fbbff'
$checksumType   = 'sha256'
$url64          = 'https://github.com/Parchive/par2cmdline/releases/download/v1.2.0/par2cmdline-1.2.0-win-x64.zip'
$checksum64     = 'c827065486fcf358fb6e5f1c6178678cf19e501a10be958e621be796da2fbbff'
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
