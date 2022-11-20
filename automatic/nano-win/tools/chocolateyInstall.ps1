$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://files.lhmouse.com/nano-win/nano-win_10141_v7.0-7-gbef7de8e9.7z'
$checksum       = '1955ebc53d54a0f0721e8fa8329d56bf826a064844b32adb8fa017de89d5a63a'
$checksumtype   = 'sha256'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    checksum      = $checksum
    checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
