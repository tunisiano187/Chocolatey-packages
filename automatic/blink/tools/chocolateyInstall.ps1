$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes     = @(0)
$toolsPath          = Split-Path $MyInvocation.MyCommand.Definition
$url                = Join-Path $toolsPath 'blink.exe'
$checksum           = '88a14a67916a3700d98b6deede1a5f689d6f9674e29da14caf76d7e80f183470'
$checksumType       = 'sha256'

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes -checksum "$checksum" -checksumType "$checksumType"