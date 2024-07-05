$packageName    = 'initool'
$url32          = 'https://github.com/dbohdan/initool/releases/download/v0.18.0/initool-v0.18.0-fc0c3b1-win32.zip'
$checksum32     = 'b3bcc11faaf1adb708d5cc764a200d9c4247a1efbbb0e68ab23f4115bdc9b71a'
$checksumType32 = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    fileType      = 'ZIP'
    url           = $url32
    checksum      = $checksum32
    checksumType  = $checksumType32
}

Install-ChocolateyZipPackage @packageArgs
