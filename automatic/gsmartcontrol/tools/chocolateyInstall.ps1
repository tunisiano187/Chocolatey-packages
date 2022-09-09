$packageName    = $env:chocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url32          = ''
$checksum32     = ''
$checksumType32 = 'sha256'
$url64          = ''
$checksum64     = ''
$checksumType64 = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -Url64bit "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType32" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"