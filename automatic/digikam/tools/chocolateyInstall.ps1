$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S'
$url32 = 'https://download.kde.org/stable/digikam/7.0.0/digiKam-7.0.0-Win32.exe'
$checksum32 = '5e3e7f6a196873d0d0391547badd06ea1d4cb627852cf0fd1b3037d3af4a7690'
$checksumType32 = 'sha256'
$url64 = 'https://download.kde.org/stable/digikam/7.0.0/digiKam-7.0.0-Win64.exe'
$checksum64 = ''
$checksumType64 = ''
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType32" `
                          -url64bit "$url64" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64" `
                          -ValidExitCodes $validExitCodes
