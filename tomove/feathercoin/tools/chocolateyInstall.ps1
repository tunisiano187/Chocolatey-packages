$SilentArgs         = '/S'
$Url                = 'https://github.com/FeatherCoin/Feathercoin/releases/download/v0.19.1/feathercoin-0.19.1-win64-setup.exe'
$Checksum           = '23b80ed7f17821b8a4340ddc8154e86774d5dfd77975305b4bcc91b01318969c'
$Checksumtype       = 'sha256'
$ValidExitCodes     = @(0)

$packageArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileType        = 'exe'
    Url             = $Url
    Checksum        = $Checksum
    ChecksumType    = $Checksumtype
    SilentArgs      = $SilentArgs
    ValidExitCodes  = $ValidExitCodes
}

Install-ChocolateyPackage @packageArgs
