$SilentArgs         = '/S'
$Url                = 'https://www.feathercoin.com/dl/feathercoin-0.8.7.1-setup.exe'
$Checksum           = ''
$Checksumtype       = ''
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