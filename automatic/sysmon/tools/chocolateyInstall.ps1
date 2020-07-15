$packageName = $env:ChocolateyPackageName
$url = 'https://download.sysinternals.com/files/Sysmon.zip'
$checksum = '8d78706b5ed7b7ec2c80bb388e3d361ba2d4b0461cbbd0c787cf523d4cfbfd81'
$checksumType = 'sha256'
$url64 = "$url"
$checksum64 = "$checksum"
$checksumType64 = "checksumType"
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Url64bit "$url64" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -Checksum64 "$checksum64" `
                             -ChecksumType64 "$checksumType64"
