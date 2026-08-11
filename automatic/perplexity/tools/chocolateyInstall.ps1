$ErrorActionPreference = 'Stop'

$url64bit      = 'https://download.todesktop.com/25020447d4kq915/Perplexity%20AI%20Setup%201.7.0-x64.exe'
$checksum64    = 'da39f74bea4996934a7cd34513905bb230ed65fb1257c15ec804a4c88a94f34b'
$checksumType64 = 'sha256'

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'EXE'
    url64bit       = $url64bit
    checksum64     = $checksum64
    checksumType64 = $checksumType64
    silentArgs     = '/S'
    validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
