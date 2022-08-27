$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$url = 'https://www.ebswift.com/uploads/7/0/4/0/70403747/scite-5.3.0x86.msi'
$checksum = 'a42afbf42629595d3e4c2fdb73f8268a566e212c09a5fff6645e0113bb26e233'
$checksumType = 'sha256'
$url64 = 'https://www.ebswift.com/uploads/7/0/4/0/70403747/scite-5.3.0x64.msi'
$checksum64 = '9aa1b30e56a346ef1697fe9f8a5ab165da2e3f13adead04abee2bad100139a2b'
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
