$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.winitor.com/tools/pestudio/current/pestudio.zip'
$checksum       = '6E2C04255FEA11B0B249A334C3D4E7632D86871A6D9990258FECDEA675176FB9'
$checksumType   = 'SHA256'

$packageArgs = @{
    packageName     = 'PeStudio'
    url             = $url
    UnzipLocation   = $toolsDir
    Checksum        = $checksum
    ChecksumType    = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
