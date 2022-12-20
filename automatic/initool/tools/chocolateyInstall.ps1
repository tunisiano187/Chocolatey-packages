$packageName    = 'initool'
$url32          = 'https://github.com/dbohdan/initool/releases/download/v0.10.0/initool-v0.10.0-e5daa7c-win32.zip'
$checksum32     = ''
$checksumType32 = ''
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"



Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url32" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum32" `
                             -ChecksumType "$checksumType32"
