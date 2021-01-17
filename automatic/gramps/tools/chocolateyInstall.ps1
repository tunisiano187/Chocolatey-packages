$ErrorActionPreference = 'Stop'
$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S'
$url                = 'https://github.com/gramps-project/gramps/releases/download/v5.1.3/GrampsAIO-5.1.3-2_win32.exe'
$checksum           = 'bbe69ebcf2f35f456243081593dcc87a7175967302638bd475a3a87ab4feb785'
$checksumType       = 'sha256'
$url64              = 'https://github.com/gramps-project/gramps/releases/download/v5.1.3/GrampsAIO-5.1.3-2_win64.exe'
$checksum64         = '0962b59f62195c8d65f2c586903dd90d578840c5edbffe98defe23951186432b'
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
