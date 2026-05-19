$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'EXE'
$url64 = 'https://eagle-updates.circuits.io/downloads/9_6_2/Autodesk_EAGLE_9.6.2_English_Win_64bit.exe'
$checksum64 = '52c350f6051486d4a6f6cd281e26cf310a0036b35a2758eefd6a66c71df5dc32'
$checksumType64 = 'sha256'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

Install-ChocolateyPackage -PackageName "$packageName" `
                             -InstallerType "$installerType" `
                             -Url64bit "$url64" `
                             -Checksum64 "$checksum64" `
                             -ChecksumType64 "$checksumType64" `
                             -SilentArgs "$silentArgs"
