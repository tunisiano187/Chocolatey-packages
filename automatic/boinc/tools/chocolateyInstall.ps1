$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S /v/qn'
$url = 'https://boinc.berkeley.edu/dl/boinc_7.24.1_windows_x86_64.exe'
$checksum = '0b3d970ecdcc431465f623a16f7b4fdf4e7baee335a2dc1e36c0602f97d81be0'
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
