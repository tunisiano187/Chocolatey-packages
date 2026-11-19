$ErrorActionPreference = 'Stop'

$packageArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileType        = 'exe'
    Url             = 'https://executor.dk/ExecutorSetup.exe'
    Checksum        = '3c4d86fc18e67af395e272dcba41f4d5b777adffcf5377d9e2d0b37bb96aa531'
    ChecksumType    = 'sha256'
    SilentArgs      = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}
Install-ChocolateyPackage @packageArgs
