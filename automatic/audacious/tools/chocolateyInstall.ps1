$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://distfiles.audacious-media-player.org/audacious-4.3-win32.exe'
$checksum = 'dd22507d2f37db55bb8fe5239ae7bc643d3c469b4f6e36edae65c14522928bce'
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
