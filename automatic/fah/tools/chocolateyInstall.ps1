$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S'
$url32       = 'https://download.foldingathome.org/releases/public/fah-client/windows-10-64bit/release/fah-client_8.3.17_AMD64.exe'
$checksum32 = 'e126d11721864c65c01e4b2e2e32a4b8bf26d340e1e797f96c2380d9a85a315b'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType" `

