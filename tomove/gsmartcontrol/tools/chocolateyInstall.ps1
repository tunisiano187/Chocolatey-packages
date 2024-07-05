$packageName    = $env:chocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/S'
$url32          = 'https://github.com/ashaduri/gsmartcontrol/releases/download/v1.1.4/gsmartcontrol-1.1.4-win32.exe'
$checksum32     = 'c10e15a727d962cd051318fcd9d5d0861d3cd1cf2f53e0c50cf7b164c2d89d5d'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/ashaduri/gsmartcontrol/releases/download/v1.1.4/gsmartcontrol-1.1.4-win64.exe'
$checksum64     = '1a06be839ca2d48ee0a86ab2c3ed7d68f8e1b5719a31a5595f84db691e192cc1'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -Url64bit "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType32" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"
