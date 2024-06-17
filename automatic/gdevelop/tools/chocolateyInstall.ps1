$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S'
$url                = 'https://github.com/4ian/GDevelop/releases/download/v5.4.203/GDevelop-5-Setup-5.4.203.exe'
$checksum           = 'f0f0be85cee3d0ef248cb582a67d8a3ea9a6991110582b0d206b31eea51fee1f'
$checksumType       = 'sha256'
$validExitCodes     = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
