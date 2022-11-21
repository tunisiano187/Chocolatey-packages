$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$url = 'https://github.com/transmission/transmission/releases/download/4.0.0-beta.1/transmission-4.0.0-beta.1%2Br98cf7d9b3c-x86.msi'
$checksum = 'ee4089752a560bfbe7a1071330931bedf3653da4ce7e2c52f4bb70a916bdb304'
$checksumType = 'sha256'
$url64 = 'https://github.com/transmission/transmission/releases/download/4.0.0-beta.1/transmission-4.0.0-beta.1%2Br98cf7d9b3c-x64.msi'
$checksum64 = '9d7039dc55b0da9518467122ed76ae33a796adf612bfcc932d29b360f47880e2'
$checksumType64 = 'sha256'
$validExitCodes = @(0,3010)

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
