$packageName    = $env:ChocolateyPackageName
$url            = 'https://github.com/lhmouse/nano-win/archive/refs/tags/v6.0.zip'
$checksum       = '81734b6a02670c2f287951b3aa81e966ff12bef120d0590db9c21a0cd8cda0bc'
$checksumtype   = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    checksum      = $checksum
    checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
