$packageName    = $env:ChocolateyPackageName
$url            = 'https://github.com//aria2/aria2/releases/download/release-1.35.0/aria2-1.35.0-win-32bit-build1.zip'
$checksum       = '60b3720d1d08ff0124224c53e5f0ee05a4427782e2abc63b6a67c023aa5ffb66'
$checksumType   = 'sha256'
$url64          = 'https://github.com//aria2/aria2/releases/download/release-1.35.0/aria2-1.35.0-win-64bit-build1.zip'
$checksum64     = '81a231aa72966cf9a7a63bf40de9053261ff6b176877685e054591849c28eafa'
$checksumType64 = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Url64 "$url64" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -Checksum64 "$checksum64" `
                             -ChecksumType64 "$checksumType64"
