$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v11.2.1/electron-v11.2.1-win32-ia32.zip'
$checksum = '7dfe726decd3567db64787b85038b50c17427ac3762541baae97764144f82dda'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v11.2.1/electron-v11.2.1-win32-x64.zip'
$checksum64 = 'd685a16bd5559355f928b1d3a389c89eca88f859510750f86299ec2688606895'
$checksumType64 = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Url64bit "$url64" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -Checksum64 "$checksum64" `
                             -ChecksumType64 "$checksumType64"
