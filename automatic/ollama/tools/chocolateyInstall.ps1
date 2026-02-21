$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/ollama/ollama/releases/download/v0.16.3/OllamaSetup.exe'
$checksum       = '118a7bfdc1a5118bdd8fd43228ddcf26e9558c02350885c53240f73ed4bd6f50'
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
