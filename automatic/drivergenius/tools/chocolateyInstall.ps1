$packageName    = 'drivergenius'
$installerType  = 'exe'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url            = 'https://www.driver-soft.com/products/DriverGenius_Setup_24.0.exe'
$checksum       = 'ab4127079529dd80c08e83e192772c2e17e7dd77af6f163f47a683014d4ba04e'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
