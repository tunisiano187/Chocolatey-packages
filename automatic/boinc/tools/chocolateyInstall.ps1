$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S /v/qn'
$url = 'https://boinc.berkeley.edu/dl/boinc_7.22.2_windows_x86_64.exe'
$checksum = '0553693c68a2e69e3287b9205bdf17953d6c5c1d9c0b94b0d334a8086985dfec'
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
