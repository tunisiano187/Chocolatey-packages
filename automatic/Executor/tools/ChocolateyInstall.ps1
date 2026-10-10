$ErrorActionPreference = 'Stop'

$packageArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileType        = 'exe'
    Url             = 'https://executor.dk/ExecutorSetup.exe'
    Checksum        = '46230b0aaf8f22b491678d3e8ca76f255ff29fcf248ce0b401b343d3d0bfb6c1'
    ChecksumType    = 'sha256'
    SilentArgs      = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}
Install-ChocolateyPackage @packageArgs
