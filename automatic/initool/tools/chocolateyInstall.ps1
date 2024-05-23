$packageName    = 'initool'
$url32          = 'https://github.com/dbohdan/initool/releases/download/v0.17.0/initool-v0.17.0-f503d7b-win32.zip'
$checksum32     = 'e5837a8895b8ad247f52736b43bddda0d87a54c2de119e1d08547e5eaed50e50'
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
