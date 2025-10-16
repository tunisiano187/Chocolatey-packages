$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '-q -overwrite'
$url            = 'https://updater.thebrain.com/files/TheBrain%2014.0.112.0%20Installer.exe'
$checksum       = '7e59532b2526bbc08794246cc4b63f607e3e09c450eaf2d5e0bc9da3cf793ae9'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
