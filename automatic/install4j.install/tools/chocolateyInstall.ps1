$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '-q'
$url            = 'https://download.ej-technologies.com/install4j/install4j_windows-x64_13_1_2.exe'
$checksum       = '260bc1daef41853367dbe7b1a8e20f63f41c3812328c8a4e453eb3baa7a549d8'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
