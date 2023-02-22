$ErrorActionPreference = 'Stop'
$packageName = 'windjview'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://sourceforge.net/projects/windjview/files/WinDjView/2.1/WinDjView-2.1-Setup.exe/download'
$checksum = '45963d6a84b06955e724e358594e9572d7eb2ce3e35a0bdbfdf57382af6a1f7f'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
