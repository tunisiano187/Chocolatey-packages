$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.winitor.com/tools/pestudio/current/pestudio.zip'
$checksum       = 'F9CBCD2AE8C3DB041E9251CA78AD7F7F8538939604EC294662FB1625ED61B5E0'
$checksumType   = 'SHA256'

$packageArgs = @{
    packageName     = 'PeStudio'
    url             = $url
    UnzipLocation   = $toolsDir
    Checksum        = $checksum
    ChecksumType    = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
