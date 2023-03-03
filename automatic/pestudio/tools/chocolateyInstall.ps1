$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.winitor.com/tools/pestudio/current/pestudio.zip'
$checksum       = '93c9ccb715de39370070656d3b1959f01dd4dc16acbb0ad9a6a3cff32c1bcb00'
$checksumType   = 'sha256'

$packageArgs = @{
    packageName     = 'PeStudio'
    url             = $url
    UnzipLocation   = $toolsDir
    Checksum        = $checksum
    ChecksumType    = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
