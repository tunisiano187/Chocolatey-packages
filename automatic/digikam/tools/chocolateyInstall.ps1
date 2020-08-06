$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S'
$url32 = 'https://download.kde.org/stable/digikam/7.0.0/digiKam-7.0.0-Win32.exe'
$checksum32 = ''
$checksumType32 = ''
$url64 = 'https://download.kde.org/stable/digikam/7.0.0/digiKam-7.0.0-Win64.exe'
$checksum64 = ''
$checksumType64 = ''
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -url64bit "$url64" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64" `
                          -ValidExitCodes $validExitCodes
