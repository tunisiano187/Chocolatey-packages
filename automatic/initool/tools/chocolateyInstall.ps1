$packageName    = 'initool'
$url32          = 'https://github.com/dbohdan/initool/releases/download/v0.12.0/initool-v0.12.0-31c7b6e-win32.zip'
$checksum32     = 'f1f7a91b91de8ec336b3b629dedc0a3a8286cc5e7577b058b626d0e25c8e6b7e'
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
