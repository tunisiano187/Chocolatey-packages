$packageName    = 'initool'
$url32          = 'https://github.com/dbohdan/initool/releases/download/v0.16.0/initool-v0.16.0-00d0f31-win32.zip'
$checksum32     = '73122865acc7399d8aa8e27b8ce2eaa70e84083e0d32cacf826803b1532e5785'
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
