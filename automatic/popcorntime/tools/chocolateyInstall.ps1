$packageName = 'popcorntime'
$installerType = 'exe'
$url64 = 'https://github.com/popcorn-official/popcorn-desktop/releases/download/v0.5.0/Popcorn-Time-0.5.0-win64-0.44.5-Setup.exe'
$checksum64 = 'b781fa573f6366e1e1428e0f3b21efd22b94e3a96db753488b73132a9db72e11'
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
