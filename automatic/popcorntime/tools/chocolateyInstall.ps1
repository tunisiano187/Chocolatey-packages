$packageName = 'popcorntime'
$installerType = 'exe'
$url = 'https://github.com/popcorn-official/popcorn-desktop/releases/download/v0.4.8/Popcorn-Time-0.4.8-win32-Setup.exe'
$checksum = '8113b619b261d64659afa5b276a92a08f009938db4f8a384b5c1cd6b89e2196a'
$checksumType = 'sha256'
$url64 = 'https://github.com/popcorn-official/popcorn-desktop/releases/download/v0.4.8/Popcorn-Time-0.4.8-win64-Setup.exe'
$checksum64 = 'f8e500cd3bbab386cc605b3f8c8b3b84f8be99db878f05ade8c132c71e00eb42'
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
