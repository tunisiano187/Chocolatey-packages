$ErrorActionPreference = 'Stop'
$packageName   = $env:ChocolateyPackageName
$url           = 'https://sourceforge.net/projects/freeplane/files/freeplane%20stable/Freeplane-Setup-1.13.3.exe/download'
$checksum      = '8D815B9EB95C1D3F2D6B5194DCF3440FA47E9850B6E9562B69F1C925134487597816FB825F184D3495B30C78330EB6FE92C4670326A49A97A8C3FE53DFA567EB'
$checksumType  = 'sha512'
$silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType 'exe' `
                          -Url "$url" `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -SilentArgs "$silentArgs" `
                          -ValidExitCodes $validExitCodes
