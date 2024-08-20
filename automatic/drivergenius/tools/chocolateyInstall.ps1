$packageName    = 'drivergenius'
$installerType  = 'exe'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url            = 'https://www.driver-soft.com/products/DriverGenius_Setup_24.0.exe'
$checksum       = 'efd7d56a39fde9ce5f1609e962b0edb42221294947d188a68a7ceba6b7811b24'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
