$ErrorActionPreference = 'Stop'

$packageArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileType        = 'exe'
    Url             = 'https://executor.dk/ExecutorSetup.exe'
    Checksum        = 'fe32f256a75e08bc739cf767261511555dfee1f3ea6d4a1a3846df2b72a75d63'
    ChecksumType    = 'sha256'
    SilentArgs      = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}
Install-ChocolateyPackage @packageArgs
