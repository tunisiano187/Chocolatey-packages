$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S'
$url32       = 'https://download.foldingathome.org/releases/public/fah-client/windows-10-64bit/release/fah-client_8.5.5_AMD64.exe'
$checksum32 = '718840240414eb065968a7a1a64b636f06857ea9ac284fbe4828cf21cd227ec9'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType" `

