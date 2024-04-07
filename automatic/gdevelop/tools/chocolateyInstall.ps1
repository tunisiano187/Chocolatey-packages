$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url                = 'https://github.com/4ian/GDevelop/releases/download/v5.3.198/GDevelop-5-Setup-5.3.198.exe'
$checksum           = 'b51b42b89832649b1d80a1590d4797696138e90452cc1bb0e0cff88566e81349'
$checksumType       = 'sha256'
$validExitCodes     = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
