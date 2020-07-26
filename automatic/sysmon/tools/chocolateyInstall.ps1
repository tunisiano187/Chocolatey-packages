$packageName = $env:ChocolateyPackageName
$url = 'https://download.sysinternals.com/files/Sysmon.zip'
$checksum = '8d78706b5ed7b7ec2c80bb388e3d361ba2d4b0461cbbd0c787cf523d4cfbfd81'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
