$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.winitor.com/tools/pestudio/current/pestudio.zip'
$checksum       = '713B0B9B6A1DAE0879B5043324427C9CA42B87DFDD35597FEC9433966831D687'
$checksumType   = 'SHA256'

$packageArgs = @{
    packageName     = 'PeStudio'
    url             = $url
    UnzipLocation   = $toolsDir
    Checksum        = $checksum
    ChecksumType    = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
