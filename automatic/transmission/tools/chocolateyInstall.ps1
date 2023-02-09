$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$url = 'https://github.com/transmission/transmission/releases/download/4.0.0/transmission-4.0.0-x86.msi'
$checksum = '1262efa209554c0ff8ef55b1626b89791c8b63dfbdaa88339c48b9797689f4bc'
$checksumType = 'sha256'
$url64 = 'https://github.com/transmission/transmission/releases/download/4.0.0/transmission-4.0.0-x64.msi'
$checksum64 = '465bb5591d76057ad781651dcfa77cb07d3c884ebe2127723c5af8e26a964a3c'
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
