$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.winitor.com/tools/pestudio/current/pestudio.zip'
$checksum       = '329B9EAEBECF6F8659F4766B81B3EC761C40B2D0BBA34A055641770E4B40B2BF'
$checksumType   = 'SHA256'

$packageArgs = @{
    packageName     = 'PeStudio'
    url             = $url
    UnzipLocation   = $toolsDir
    Checksum        = $checksum
    ChecksumType    = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
