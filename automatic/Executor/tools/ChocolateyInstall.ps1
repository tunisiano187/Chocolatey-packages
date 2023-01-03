$ErrorActionPreference = 'Stop'

$packageArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileType        = 'exe'
    Url             = 'http://www.1space.dk/executor/ExecutorSetup.exe'
    Checksum        = 'ae6fa48557c7aef38c648c0ee33785d5b0c9a557f0f6a23b8395091d7299ec2b'
    ChecksumType    = 'sha256'
    SilentArgs      = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}
Install-ChocolateyPackage @packageArgs
