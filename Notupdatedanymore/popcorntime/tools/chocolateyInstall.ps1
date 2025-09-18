$packageName = 'popcorntime'
$installerType = 'exe'
$url64 = 'https://github.com/popcorn-official/popcorn-desktop/releases/download/v0.5.1/Popcorn-Time-0.5.1-win64-0.44.5-Setup.exe'
$checksum64 = '1276272082e670c73b8c7bd2d7256301098ef428cc55a0a16bd53e1728e57720'
$checksumType64 = 'sha256'
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url64" `
                          -Checksum "$checksum64" `
                          -ChecksumType "$checksumType64" `
                          -ValidExitCodes $validExitCodes
