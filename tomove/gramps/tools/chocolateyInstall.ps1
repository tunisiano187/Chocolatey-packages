$ErrorActionPreference = 'Stop'
$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S'
#$url                = 'https://github.com/gramps-project/gramps/releases/download/v5.1.5/GrampsAIO-5.1.5-1_win32.exe'
#$checksum           = '6e4de1efa0aaa399c0037528d19eec66470ae7369868b1c4bc68b3c24878d01c'
#$checksumType       = 'sha256'
$url64              = 'https://github.com/gramps-project/gramps/releases/download/v5.2.2/GrampsAIO-5.2.2-1_win64.exe'
$checksum64         = 'ee6d197e06dadadf3cf11f425a80b3250b398e731309850f6fd99a1ec1962b46'
$checksumType64     = 'sha256'
$validExitCodes     = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum64" `
                          -ChecksumType "$checksumType64"
