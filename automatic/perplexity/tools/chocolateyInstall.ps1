$ErrorActionPreference = 'Stop'

$packageName    = $env:ChocolateyPackageName
$url64          = 'https://download.todesktop.com/25020447d4kq915/Perplexity%20AI%20Setup%201.7.0-x64.exe'
$checksum64     = '1a6ca3507b40dfa1dc6ea0039be1979ee3d620e25899c07cba1b877ec575079915403a55fb447b7969ee33a43130bc05c5c976d37f841394174c6d04d7eb0dba'
$checksumType64 = 'sha512'

$packageArgs = @{
    packageName    = $packageName
    fileType       = 'EXE'
    url64bit       = $url64
    checksum64     = $checksum64
    checksumType64 = $checksumType64
    silentArgs     = '/S'
    validExitCodes = @(0)
    softwareName   = 'Perplexity*'
}

Install-ChocolateyPackage @packageArgs
