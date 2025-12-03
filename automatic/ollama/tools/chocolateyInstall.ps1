$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/ollama/ollama/releases/download/v0.13.1/OllamaSetup.exe'
$checksum       = '10ee5abd776625e7ea9c9a80413c71a1dcc68c4319eee792b4ac8dd8eddf3d6d'
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
