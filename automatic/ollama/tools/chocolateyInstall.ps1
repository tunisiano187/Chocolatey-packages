$ErrorActionPreference = 'Stop';
$url            = 'https://github.com/ollama/ollama/releases/download/v0.1.26/OllamaSetup.exe'
$checksum       = 'CACB2123E27CE31C065B723061EF6784308D77840AC0D554DD7696BEB23FC542'
$checksumType   = 'sha256'

$packageArgs = @{
    packageName            = $env:ChocolateyPackageName
    fileType               = 'EXE'
    url                    = $url
    checksum               = $checksum
    checksumType           = $checksumType
    silentArgs             = '/S'
    validExitCodes         = @(0)
}

Install-ChocolateyPackage @packageArgs