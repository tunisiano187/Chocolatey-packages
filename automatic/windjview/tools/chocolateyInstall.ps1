$ErrorActionPreference = 'Stop'
$packageName = 'windjview'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://sourceforge.net/projects/windjview/files/WinDjView/2.1/WinDjView-2.1-Setup.exe/download'
$checksum = 'C46A0B6B2C1C289B99FC92212443C911B80A899DDC772442E1A47264C9039C5C'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
