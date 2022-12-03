$installerType  = 'exe'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url32          = 'https://github.com/jaruba/PowderPlayer/releases/download/v1.20/PowderPlayer_v1.20.exe'
$checksum32     = '7f365e1455e0a25361495ec428431fbf80a12dca20110ed7263f0ea78d00efc1'
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