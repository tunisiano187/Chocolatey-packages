$packageName = 'hddguardian'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://files1.majorgeeks.com/10afebdbffcd4742c81a3cb0f6ce4092156b4375/drives/hddguardian_0.7.1-setup.exe'
$checksum = '0772dc4898a925f21bb5264b0ee67dcd813b4e97c2676bd95acdb27035fea06d'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
