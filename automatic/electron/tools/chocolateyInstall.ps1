$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v32.0.2/electron-v32.0.2-win32-ia32.zip'
$checksum = 'db51395aa835773b21390c3cd12d14c632f990b909621f01139234eb87a4c394'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v32.0.2/electron-v32.0.2-win32-x64.zip'
$checksum64 = '16edf270a25c60f97e1efa86680ca53d5724d1a24ead250b0d40c0ce0119ce42'
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
