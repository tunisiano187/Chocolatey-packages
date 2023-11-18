$packageName    = 'initool'
$url32          = 'https://github.com/dbohdan/initool/releases/download/v0.14.1/initool-v0.14.1-139776d-win32.zip'
$checksum32     = '73206bf2896a7457cbec4988adc21e0192ac0b6aba09b4ddde57621125958521'
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
