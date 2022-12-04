$installerType  = 'exe'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url32          = 'https://github.com/jaruba/PowderPlayer/releases/download/v1.60/PowderPlayer_v1.60.exe'
$checksum32     = 'bc5c3347a0b2a01b8c50d37b2898334d7455cb8432e5f6a3dc70d130a6ddb184'
$checksumType32 = 'sha256'
$validExitCodes = @(0)

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    FileType        = $installerType
    SilentArgs      = $silentArgs

    url             = $url32
    checksum        = $checksum32
    checksumType    = $checksumType32
    ValidExitCodes  = $validExitCodes
}

Install-ChocolateyPackage @packageArgs
