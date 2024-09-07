$ErrorActionPreference = 'Stop';
$packageName = 'Ollama'
$url = 'https://github.com/ollama/ollama/releases/download/v0.1.26/OllamaSetup.exe'
$installerType = 'exe'
$checksum = 'CACB2123E27CE31C065B723061EF6784308D77840AC0D554DD7696BEB23FC542'
$checksumType = 'sha256'
$silentArgs = '/S'
$validExitCodes = @(0)

$installPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$downloadFile = Join-Path $installPath "$($packageName)Setup.exe"

Get-ChocolateyWebFile -PackageName $packageName `
                      -FileFullPath $downloadFile `
                      -Url $url `
                      -Checksum $checksum `
                      -ChecksumType $checksumType
Install-ChocolateyInstallPackage -PackageName $packageName `
                                 -FileType $installerType `
                                 -SilentArgs $silentArgs `
                                 -File $downloadFile `
                                 -ValidExitCodes $validExitCodes
