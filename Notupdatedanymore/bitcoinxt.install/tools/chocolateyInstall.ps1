$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com//bitcoinxt/bitcoinxt/releases/download/v0.11K/bitcoin-0.11.0-win32-setup-unsigned.exe'
$checksum = '403943a9d558c53497ae72facb27094b3d2500ba2fcf5676a6e27ad3b952f4f6'
$checksumType = 'sha256'
$url64 = 'https://github.com//bitcoinxt/bitcoinxt/releases/download/v0.11K/bitcoin-0.11.0-win64-setup-unsigned.exe'
$checksum64 = '30c56f4def9e428c5769107ef5a20753c00e0668d23aa9a1ece4c538d919ee1c'
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
