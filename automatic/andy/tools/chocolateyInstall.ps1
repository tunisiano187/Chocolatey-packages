$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url            = 'https://sdl.adaware.com/?bundleid=AR001&savename=Andy_47.260_1096_26_x86.exe'
$checksum       = ''
$checksumType   = ''
$url64          = 'https://sdl.adaware.com/?bundleid=AR001&savename=Andy_47.260_1096_26_x64.exe'
$checksum64     = ''
$checksumType64 = ''
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -Url64 "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"
