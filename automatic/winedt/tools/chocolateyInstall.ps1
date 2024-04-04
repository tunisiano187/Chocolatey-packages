$packageName = 'winedt'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'http://www.winedt.com/download/winedt103-32.exe'
$checksum = 'e40d10105eed97e518c04c1ce29e6dfb1cf70e389d46567feb08b05424a4dc2a'
$checksumType = 'sha256'
$url64 = 'http://www.winedt.com/download/winedt103-64.exe'
$checksum64 = '025c27022824371a571a1fd736baed572ac6122edc547af8b4b618c8172c61b0'
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