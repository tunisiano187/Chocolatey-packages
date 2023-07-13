$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://ftp.binance.com/electron-desktop/windows/production/binance-setup.exe'
$checksum = '00f7f6e3b325c921726fa0f63c5450fff3258a9afa14c2752fe9d149793a43f3'
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
