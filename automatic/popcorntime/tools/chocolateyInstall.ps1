$packageName = 'popcorntime'
$installerType = 'exe'
$url = 'https://github.com/popcorn-official/popcorn-desktop/releases/download/v0.4.5/Popcorn-Time-0.4.5-win32-Setup.exe'
$checksum = '971b6dab5bbd2f851e668893e673681108c595ed22c8f2927d419db753f147c5'
$checksumType = 'sha256'
$url64 = 'https://github.com/popcorn-official/popcorn-desktop/releases/download/v0.4.5/Popcorn-Time-0.4.5-win64-Setup.exe'
$checksum64 = '3a825270715bce0eb40925708bdbbd82bb50522ec693e51001aac758de47192f'
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
