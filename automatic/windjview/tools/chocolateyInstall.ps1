$packageName = 'windjview'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://sourceforge.net/projects/windjview/files/WinDjView/2.1/WinDjView-2.1-Setup.exe/download'
$checksum = 'edd0016a9b528243e5eaff9677237059d3bc3ca7ea5dad28885c267728f61a98'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
