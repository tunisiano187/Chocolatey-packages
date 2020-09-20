$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$url = 'https://www.ebswift.com/uploads/7/0/4/0/70403747/scite-4.4.5x86.msi'
$checksum = '1206797d004fd70449081b1d15364b3d1e182f82e7785e66bcec2dd8435a2469'
$checksumType = 'sha256'
$url64 = 'https://www.ebswift.com/uploads/7/0/4/0/70403747/scite-4.4.5x64.msi'
$checksum64 = 'adfcbe6398a3e3582f05f198770fde6a61de27bd879fbbeb4370eeb5549c3735'
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
