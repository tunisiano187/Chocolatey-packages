$ErrorActionPreference = 'Stop'
$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S'
#$url                = 'https://github.com/gramps-project/gramps/releases/download/v5.1.5/GrampsAIO-5.1.5-1_win32.exe'
#$checksum           = '6e4de1efa0aaa399c0037528d19eec66470ae7369868b1c4bc68b3c24878d01c'
#$checksumType       = 'sha256'
$url64              = 'https://github.com/gramps-project/gramps/releases/download/v5.2.1/GrampsAIO-5.2.1-1_win64.exe'
$checksum64         = '6796a6f21e345eb6868e102f1afc55cc5e39e9c14be73daff9d6b850e51237e7'
$checksumType64     = 'sha256'
$validExitCodes     = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum64" `
                          -ChecksumType "$checksumType64"
