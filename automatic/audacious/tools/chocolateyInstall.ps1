$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://distfiles.audacious-media-player.org/audacious-4.4-beta1-win32.exe'
$checksum = 'e26e4fb2eb7a9ca1d539b51f43ec384df477359f49d0f676c6ca1de3921f8a9f'
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
