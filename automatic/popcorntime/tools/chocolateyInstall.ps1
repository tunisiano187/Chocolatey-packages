$packageName = 'popcorntime'
$installerType = 'exe'
$url = 'https://github.com/popcorn-official/popcorn-desktop/releases/download/v0.4.7/Popcorn-Time-0.4.7-win32-Setup.exe'
$checksum = '8c7595e10dd45cedf0344593709a39626525c1ab6272969a6370fd96aa735b64'
$checksumType = 'sha256'
$url64 = 'https://github.com/popcorn-official/popcorn-desktop/releases/download/v0.4.7/Popcorn-Time-0.4.7-win64-Setup.exe'
$checksum64 = '5067ecb7b4fcdac43f12b4c464b1fd72aacefcaba4b58b2bddbcd3519c0bf883'
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
