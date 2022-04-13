$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://files.lhmouse.com/nano-win/nano-win_10014_v6.2-44-g829f90c98.7z'
$checksum       = '4bad3f7a72733bf7bf5987ecf9c16f8fd47564d1bcfe559112d2b525ce7d8adf'
$checksumtype   = 'sha256'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    checksum      = $checksum
    checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
