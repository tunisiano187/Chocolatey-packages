$packageName    = 'initool'
$url32          = 'https://github.com/dbohdan/initool/releases/download/v0.10.0/initool-v0.10.0-e5daa7c-win32.zip'
$checksum32     = ''
$checksumType32 = ''
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
