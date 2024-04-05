$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url            = 'https://www.winedt.com/download/winedt11.exe'
$checksum       = '0353ea1e5010a38c6bf8e2d5ed4cf9b935f81e11a96679c5cad69d5c51573e2a'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
