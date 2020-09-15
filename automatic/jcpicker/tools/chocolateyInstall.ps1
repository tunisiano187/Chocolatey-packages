$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$url            = 'https://annystudio.com/jcpicker.zip'
$checksum       = 'a9fbfd326c40e67954178fd3aa04039d6003c751b37bb4754daee9b9588a9b8f'
$checksumType   = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

