$ErrorActionPreference = 'Stop'
$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S'
$url                = 'https://github.com/gramps-project/gramps/releases/download/v5.1.3/GrampsAIO-5.1.3-1_win32.exe'
$checksum           = 'da88cb39bf75ebcbbf22c9e276e682620ddb4885ca7c04f1d3922d818095c0e3'
$checksumType       = 'sha256'
$url64              = 'https://github.com/gramps-project/gramps/releases/download/v5.1.3/GrampsAIO-5.1.3-2_win32.exe'
$checksum64         = 'bbe69ebcf2f35f456243081593dcc87a7175967302638bd475a3a87ab4feb785'
$checksumType64     = 'sha256'
$validExitCodes     = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -Url64bit "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"
