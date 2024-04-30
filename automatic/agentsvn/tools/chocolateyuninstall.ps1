$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = 'agentsvn'
$installerType = 'exe'
$silentArgs = '/sp- /silent /norestart /suppressmsgboxes'

if (Test-Path '${env:ProgramFiles(x86)}\AgentSVN') {
    Uninstall-ChocolateyPackage $packageName $installerType $silentArgs '${env:ProgramFiles(x86)}\AgentSVN\unins000.exe'
}
