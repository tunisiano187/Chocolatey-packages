$ErrorActionPreference = 'Stop'

$packageArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileType        = 'exe'
    Url             = 'http://www.1space.dk/executor/ExecutorSetup.exe'
    Checksum        = 'ac955d0e00a7f4b2a455c4d193253d82aeea94fd58b5a2335160c3d589cc4ed3'
    ChecksumType    = 'sha256'
    SilentArgs      = '/SILENT /VERYSILENT /SUPRESSMSGBOXES /SP-'
}
Install-ChocolateyPackage @packageArgs
