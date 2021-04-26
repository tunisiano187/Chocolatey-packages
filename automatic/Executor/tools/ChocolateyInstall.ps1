$ErrorActionPreference = 'Stop'

$packageArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileType        = 'exe'
    Url             = 'http://www.1space.dk/executor/ExecutorSetup.exe'
    Checksum        = '5b4eb20110b7e1240a747dba56ea1e8d5c0c8bb63eb0e6d7f00efb81af854953'
    ChecksumType    = 'sha256'
    SilentArgs      = '/SILENT /VERYSILENT /SUPRESSMSGBOXES /SP-'
}
Install-ChocolateyPackage @packageArgs
