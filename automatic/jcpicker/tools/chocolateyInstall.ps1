$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$url            = 'https://annystudio.com/jcpicker.zip'
$checksum       = '099a5556d5710058a5a26798da2cc9a4686fdeeec49400e5aa6134a1a6af2f45'
$checksumType   = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

