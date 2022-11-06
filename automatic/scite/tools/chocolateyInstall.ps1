$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$url = 'https://www.ebswift.com/uploads/7/0/4/0/70403747/scite-5.3.1x86.msi'
$checksum = 'b41fca09aca334cd9e33bb760d2ce0c1bd8999bd3d0d9164e832b68a50bea324'
$checksumType = 'sha256'
$url64 = 'https://www.ebswift.com/uploads/7/0/4/0/70403747/scite-5.3.1x64.msi'
$checksum64 = 'd50d6c9166e8a87fff6a910ff3a5d8010e98bc73d4acf3cb9ee59b3ca2d2573a'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

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
