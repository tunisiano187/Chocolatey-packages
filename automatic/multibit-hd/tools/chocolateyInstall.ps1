$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '-q'
$url = 'https://github.com//Multibit-Legacy/multibit-hd/releases/download/v0.5.1/multibit-windows-0.5.1.exe'
$checksum = '1eb80f6866cf4738bd94cf0f19e01d6141082fc44f15747eed70db5a9513288b'
$checksumType = 'sha256'
$url64 = 'https://github.com//Multibit-Legacy/multibit-hd/releases/download/v0.5.1/multibit-windows-x64-0.5.1.exe'
$checksum64 = '6d6a760a0b069cef086895982e4a1ba3dc4e213c5443782853d3c967cdcbd926'
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
