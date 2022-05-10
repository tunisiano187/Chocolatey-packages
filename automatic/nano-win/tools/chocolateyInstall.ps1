$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://files.lhmouse.com/nano-win/nano-win_10020_v6.3-7-g23c4ee8c3.7z'
$checksum       = '8f20fc6155a44cbc474884e074cf7e7fc153b41c69867b39d6cea6d32d75b069'
$checksumtype   = 'sha256'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    checksum      = $checksum
    checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
