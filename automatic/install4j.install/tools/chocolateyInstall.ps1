$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '-q'
$url            = 'https://download.ej-technologies.com/install4j/install4j_windows-x64_12_0_2.exe'
$checksum       = 'd4151b08f8919aab6bf5d04e9690c5df1e020f7cafc050ef71bd42c25a898e39'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
