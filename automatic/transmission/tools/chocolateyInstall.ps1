$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$url = 'https://github.com/transmission/transmission/releases/download/3.00/transmission-3.00-x86.msi'
$checksum = 'eeab85327fa8a1299bb133d5f60f6674ca9e76522297202bbe39aae92dad4f32'
$checksumType = 'sha256'
$url64 = 'https://github.com/transmission/transmission/releases/download/3.00/transmission-3.00-x64.msi'
$checksum64 = 'c34828a6d2c50c7c590d05ca50249b511d46e9a2a7223323fb3d1421e3f6b9d1'
$checksumType64 = 'sha256'
$validExitCodes = @(0,3010)

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
