$packageName    = 'drivergenius'
$installerType  = 'exe'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url            = 'https://www.driver-soft.com/products/DriverGenius_Setup_25.0.exe'
$checksum       = 'b694e42a4b4fa666dda510b62a50e4bed41b5298268564379844c35d6979b4f5'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
