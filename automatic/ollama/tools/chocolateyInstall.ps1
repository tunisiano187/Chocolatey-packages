$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/ollama/ollama/releases/download/v0.23.4/OllamaSetup.exe'
$checksum       = 'b0ac7cb7bb70cc0637479d7ab3cb1632086c6101786419bcd8efc5f472771ae0'
$checksumType   = 'sha256'

$packageArgs = @{
    packageName            = $env:ChocolateyPackageName
    fileType               = 'EXE'
    url                    = $url
    checksum               = $checksum
    checksumType           = $checksumType
    silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes         = @(0)
}

Install-ChocolateyPackage @packageArgs
