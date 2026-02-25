$packageName    = 'drivergenius'
$installerType  = 'exe'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url            = 'https://www.driver-soft.com/products/DriverGenius_Setup_25.0.exe'
$checksum       = 'c2bc735ca0428b00bb74d50c154d4ed99d4169455f4c04544d561b319f4c74bc'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
