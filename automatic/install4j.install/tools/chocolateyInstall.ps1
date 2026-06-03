$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '-q'
$url            = 'https://download.ej-technologies.com/install4j/install4j_windows-x64_13_0.exe'
$checksum       = '11a110e1b4680fa965820639498d9baf8891bd8cb0865650c08fc0d3e0453aec'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
