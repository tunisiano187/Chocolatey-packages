$packageName    = 'initool'
$url32          = 'https://github.com/dbohdan/initool/releases/download/v0.11.0/initool-v0.11.0-f5f28e6-win32.zip'
$checksum32     = '6b30c126b7d12276a17c572622ee34b839bbbf45b96a7c87c676cab4304f64e8'
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
