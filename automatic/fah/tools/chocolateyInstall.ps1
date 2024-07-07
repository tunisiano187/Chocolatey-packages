$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S'
$url32       = 'https://download.foldingathome.org/releases/public/fah-client/windows-10-64bit/release/fah-client_8.3.17_AMD64.exe'
$checksum32 = '02b5321d6c57f1edc898290ff3e95674e1246c327dd150f1ef157519e2577f8f'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType" `

