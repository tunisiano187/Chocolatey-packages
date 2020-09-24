$packageName = 'popcorntime'
$installerType = 'exe'
$url = 'https://github.com/popcorn-official/popcorn-desktop/releases/download/v0.4.4/Popcorn-Time-0.4.4-win32-Setup.exe'
$checksum = 'bd25a2aaf6ae264de299cd0e538bcafb3ef5682d080ef405232b64c8d9261169'
$checksumType = 'sha256'
$url64 = 'https://github.com/popcorn-official/popcorn-desktop/releases/download/v0.4.4/Popcorn-Time-0.4.4-win64-Setup.exe'
$checksum64 = 'c92dcddf5d7e6067b4b4af33514eb2ac34e348e98c52c0b01ddbf6afd6ce7fde'
$checksumType64 = 'sha256'
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -Url64 "$url64" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64" `
                          -ValidExitCodes $validExitCodes
