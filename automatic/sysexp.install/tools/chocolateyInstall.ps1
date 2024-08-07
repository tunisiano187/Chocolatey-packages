$packageName    = 'sysexp.install'
$installerType  = 'exe'
$url            = 'https://www.nirsoft.net/utils/sysexp_setup.exe'
$checksum       = '9a38499ac2ecb2ce0851aad0018c5bc517fb635dbc01899973f4cb798cdb4cd4'
$checksumType   = 'sha256'
$silentArgs     = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -Url "$url" `
                          -SilentArgs "$silentArgs" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
