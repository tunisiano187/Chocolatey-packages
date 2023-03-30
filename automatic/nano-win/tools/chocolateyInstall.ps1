$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://files.lhmouse.com/nano-win/nano-win_10180_v7.2-25-g44c0d924b.7z'
$checksum       = '4012ed5fd32d3784c7e13d0b48d7a0991dc974e2b21b68a303124060fb1a90d1'
$checksumtype   = 'sha256'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    checksum      = $checksum
    checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
