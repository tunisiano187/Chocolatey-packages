$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S /v/qn'
$url = 'https://boinc.berkeley.edu/dl/boinc_7.20.2_windows_x86_64.exe'
$checksum = '34de8ad3ad50fd194ac2e198468d0fc82700ee3b99ae1781d884b6d5012c26d3'
$checksumType = 'sha256'
$validExitCodes = @(0)

$packageArgs = @{
    packageName     = $packageName
    fileType        = $installerType
    url             = $url
    silentArgs      = $silentArgs
    validExitCodes  = $validExitCodes
    softwareName    = "$packageName*"
    checksum        = $checksum
    checksumType    = $checksumType
}

Install-ChocolateyPackage @packageArgs
