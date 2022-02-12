$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$url = 'https://www.ebswift.com/uploads/7/0/4/0/70403747/scite-5.2.0x86.msi'
$checksum = '1d126703599a210727bfb5a460d73d06b2c0174f303ec1561d07662563210e77'
$checksumType = 'sha256'
$url64 = 'https://www.ebswift.com/uploads/7/0/4/0/70403747/scite-5.2.0x64.msi'
$checksum64 = 'beee80a304d6b44fa6e4f43007294392742f7653eebaab84941e94dac61c46b5'
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
