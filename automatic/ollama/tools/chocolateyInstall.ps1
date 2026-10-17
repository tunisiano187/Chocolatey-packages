$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/ollama/ollama/releases/download/v0.40.6/OllamaSetup.exe'
$checksum       = '933794ee1d670137f5116c9de7fc7db092fa97c6b823aba848ddb8a7ea030828'
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
