$packageName    = 'initool'
$url32          = 'https://github.com/dbohdan/initool/releases/download/v0.13.0/initool-v0.13.0-d75e3e3-win32.zip'
$checksum32     = '185a21002551ff37fe77a9d23467dabef48aa41cbc5d49975efda1cd37ea2978'
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
