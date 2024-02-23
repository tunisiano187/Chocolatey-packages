$packageName = 'popcorntime'
$installerType = 'exe'
$url = 'https://github.com/popcorn-official/popcorn-desktop/releases/download/v0.5.0/Popcorn-Time-0.5.0-win32-0.44.5-Setup.exe'
$checksum = '2c299c5c4a4b04767abab14e23d4c0a4e751d8bf1699e7f4cdf32ab96ca63c7c'
$checksumType = 'sha256'
$url64 = 'https://github.com/popcorn-official/popcorn-desktop/releases/download/v0.5.0/Popcorn-Time-0.5.0-win64-0.44.5-Setup.exe'
$checksum64 = 'b781fa573f6366e1e1428e0f3b21efd22b94e3a96db753488b73132a9db72e11'
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
