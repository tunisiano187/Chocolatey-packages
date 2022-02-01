$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.5/dogecoin-1.14.5-win32-setup-unsigned.exe'
$checksum = '186cb2cd0a8926dc10cdc15b3e78ae1b825c79953c2c5c6b55b69e0749a5de1d'
$checksumType = 'sha256'
$url64 = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.5/dogecoin-1.14.5-win64-setup-unsigned.exe'
$checksum64 = 'a1c14d75b3ff45ad4cbf1efa5fcbb457186e88298ca7a6e74818f0897cf8d606'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -Url64bit "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"
