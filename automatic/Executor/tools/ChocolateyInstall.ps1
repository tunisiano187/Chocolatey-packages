$ErrorActionPreference = 'Stop'

$packageArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileType        = 'exe'
    Url             = 'http://www.1space.dk/executor/ExecutorSetup.exe'
    Checksum        = '4f9666d647019a488e7959831505ea0c05083a60e0d33f191c25bc872e419bdd'
    ChecksumType    = ''
    SilentArgs      = '/SILENT /VERYSILENT /SUPRESSMSGBOXES /SP-'
}
Install-ChocolateyPackage @packageArgs
