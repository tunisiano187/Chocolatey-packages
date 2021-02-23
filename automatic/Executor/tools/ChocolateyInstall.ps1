$ErrorActionPreference = 'Stop'

$packageArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileType        = 'exe'
    Url             = 'http://www.1space.dk/executor/ExecutorSetup.exe'
    Checksum        = '63d565ec701ba49c3eb58e814796aa9fbf8c690669d9a6167de1b8a3cf5955c0'
    ChecksumType    = 'sha256'
    SilentArgs      = '/SILENT /VERYSILENT /SUPRESSMSGBOXES /SP-'
}
Install-ChocolateyPackage @packageArgs
