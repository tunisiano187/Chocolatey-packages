$packageName = 'removeemptydirectory'
$installerType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url = 'https://vorboss.dl.sourceforge.net/project/rem-empty-dir/red-v2.2-setup.exe'
$checksum = '60CB4399ABFEA5AA8BE713568A4E4D5CF4239586'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `

