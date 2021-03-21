$ErrorActionPreference = 'Stop'

$packageArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileType        = 'exe'
    Url             = 'http://www.1space.dk/executor/ExecutorSetup.exe'
    Checksum        = '1319b2dd7bf34d752b10b2f4c5659f2ea51df1058868bef171c835d96105245e'
    ChecksumType    = 'sha256'
    SilentArgs      = '/SILENT /VERYSILENT /SUPRESSMSGBOXES /SP-'
}
Install-ChocolateyPackage @packageArgs
