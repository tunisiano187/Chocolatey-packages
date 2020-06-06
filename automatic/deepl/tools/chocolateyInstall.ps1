$packageName = 'deepl'
$installerType = 'exe'
$silentArgs = '/S'
$url64 = 'https://appdownload.deepl.com/windows/full/DeepLSetup.exe'
$checksum64 = '1498BFCA4361B90D9F7F0345A5E0981B257270CC2D52761B4D3464FE22F8C6F4'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

Invoke-WebRequest -Uri $url64 -OutFile ".\DeepLSetup.exe"

$url64 = ".\DeepLSetup.exe"

invoke-expression 'cmd /c start powershell -Command { Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url64bit "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64" }'