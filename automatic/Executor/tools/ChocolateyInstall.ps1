$ErrorActionPreference = 'Stop'

$packageArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileType        = 'exe'
    Url             = 'https://executor.dk/ExecutorSetup.exe'
    Checksum        = '1142a7e495b8c8aca210570974bd3cb0db74104c9358fb654dfd35dee2157c06'
    ChecksumType    = 'sha256'
    SilentArgs      = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}
Install-ChocolateyPackage @packageArgs
