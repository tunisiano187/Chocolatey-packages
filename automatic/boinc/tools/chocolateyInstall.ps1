$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S /v/qn'
$url = 'https://boinc.berkeley.edu/dl/boinc_7.16.11_windows_x86_64.exe'
$checksum = '28b1aa0f7edbd78402b7163bc483a909b156064860b8890e52667a597079fb33'
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
