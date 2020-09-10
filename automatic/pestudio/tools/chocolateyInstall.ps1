$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = ''
$checksum       = ''
$checksumType   = ''

$packageArgs = @{
    packageName     = 'PeStudio'
    url             = $url
    UnzipLocation   = $toolsDir
    Checksum        = $checksum
    ChecksumType    = $checksumType
}

Install-ChocolateyZipPackage @packageArgs