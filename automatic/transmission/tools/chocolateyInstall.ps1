$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$url = 'https://github.com/transmission/transmission/releases/download/4.0.0-beta.3/transmission-4.0.0-beta.3+r634b1e8fc1-x86.msi'
$checksum = '0bfa6335852734265eef384a4d8ca7759851b9d04868b1b3a9275c19a8b5021b'
$checksumType = 'sha256'
$url64 = 'https://github.com/transmission/transmission/releases/download/4.0.0-beta.3/transmission-4.0.0-beta.3+r634b1e8fc1-x64.msi'
$checksum64 = '755b3e01f7039af7007882cf236330e4d9047bddabddf6e758f16a9a0d102535'
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
