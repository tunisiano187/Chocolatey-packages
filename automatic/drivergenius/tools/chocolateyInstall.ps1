$packageName    = 'drivergenius'
$installerType  = 'exe'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url            = 'https://www.driver-soft.com/products/DriverGenius_Setup_26.0.exe'
$checksum       = 'd29655af074e54322d36e9b71a13c51aff1aa977055207346e63e8f6fdbe4ae4'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
