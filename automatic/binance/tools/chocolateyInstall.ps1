$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://ftp.binance.com/electron-desktop/windows/production/binance-setup.exe'
$checksum = '88ba50e23b02d26e46ffd6dd7e8fac25db107d4f7e0cdb966b0f6682e1768eeb'
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
