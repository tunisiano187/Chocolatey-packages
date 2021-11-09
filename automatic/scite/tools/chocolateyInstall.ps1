$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$url = 'https://www.ebswift.com/uploads/7/0/4/0/70403747/scite-5.1.5x86.msi'
$checksum = '633c47f5ad41b5803fb2d4feb73f13c174455f4579d24119d7adcbeb7df263c9'
$checksumType = 'sha256'
$url64 = 'https://www.ebswift.com/uploads/7/0/4/0/70403747/scite-5.1.5x64.msi'
$checksum64 = '03628796a78cd06455ec3ccbc724e1088572663977b2c903c936f4dae53d27bc'
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
