$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://ftp.binance.com/electron-desktop/windows/production/binance-setup.exe'
$checksum = 'dd9563a485164b1bcadff2a61252b0d50ef543c6cad180e187d903f329a5f4e3'
$checksumType = 'sha256'
$silentArgs = '/S'
$validExitCodes = @(0)

$packageArgs = @{
    packageName     = $packageName
    fileType        = 'exe'
    url             = $url
    silentArgs      = $silentArgs
    validExitCodes  = $validExitCodes
    softwareName    = "$packageName*"
    checksum        = $checksum
    checksumType    = $checksumType
}

Install-ChocolateyPackage @packageArgs
