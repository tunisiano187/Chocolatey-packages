$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://download.electrum.org/4.2.0/electrum-4.2.0-setup.exe'
$checksum = '6d3fd16510ea73a46fefa14f7d597e0b50c312a36b79ab8a86deb9cd82513d3d'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
