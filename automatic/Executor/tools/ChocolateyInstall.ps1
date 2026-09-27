$ErrorActionPreference = 'Stop'

$packageArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileType        = 'exe'
    Url             = 'https://executor.dk/ExecutorSetup.exe'
    Checksum        = 'fca47b6e174f9418008d04d45d8289935fd4ae76b12093ec780a74e0057afdcb'
    ChecksumType    = 'sha256'
    SilentArgs      = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}
Install-ChocolateyPackage @packageArgs
