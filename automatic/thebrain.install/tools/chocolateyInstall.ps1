$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '-q -overwrite'
$url            = 'https://updater.thebrain.com/files/TheBrain%2014.0.46.0%20Installer.exe'
$checksum       = 'cc939290c8c00264be56b2241f86e3e44d98fba5d7e5c89a5fcc2e05977e2430'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
