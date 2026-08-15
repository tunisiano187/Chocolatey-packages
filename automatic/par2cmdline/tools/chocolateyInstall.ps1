$url            = 'https://github.com/Parchive/par2cmdline/releases/download/v1.3.0/par2cmdline-1.3.0-win-x64.zip'
$checksum       = '4164d2e689b6bca6a14c4d4a303582ff40307b5739737f1d29695b65002b13ea'
$checksumType   = 'sha256'
$url64          = 'https://github.com/Parchive/par2cmdline/releases/download/v1.3.0/par2cmdline-1.3.0-win-x64.zip'
$checksum64     = '4164d2e689b6bca6a14c4d4a303582ff40307b5739737f1d29695b65002b13ea'
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
