$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$url = 'https://github.com/transmission/transmission/releases/download/4.0.0-beta.2/transmission-4.0.0-beta.2%2Brbceb368f1b-x86.msi'
$checksum = '421e136baee96d526f5f2175cb135de5189bec2254ab79299086855205e99a4f'
$checksumType = 'sha256'
$url64 = 'https://github.com/transmission/transmission/releases/download/4.0.0-beta.2/transmission-4.0.0-beta.2%2Brbceb368f1b-x64.msi'
$checksum64 = '7c5dffae356230aee7e2828b79bf39460725a67a4eff72a4bfa01809742d10fa'
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
