$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/ollama/ollama/releases/download/v0.40.18/OllamaSetup.exe'
$checksum       = 'ad2bb47aa969b21cf8dd81b2d9f9a6d5030270ed242ef55087118c37c510acc2'
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
