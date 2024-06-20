$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S'
$url                = 'https://github.com/4ian/GDevelop/releases/download/v5.4.204/GDevelop-5-Setup-5.4.204.exe'
$checksum           = 'c81cb6e9a1fa1f8be804ed9443280a62d1079e8b65766fbf22b7c29e507081f8'
$checksumType       = 'sha256'
$validExitCodes     = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
