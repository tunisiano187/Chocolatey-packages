$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$toolsPath\helpers.ps1"
Write-Host "Importing necessary certificates..."
$certificates = Get-ChildItem "$toolsPath\*.cer"
$certificates | ForEach-Object {
  Import-Certificate -FilePath $_ -CertStoreLocation "Cert:\LocalMachine\TrustedPublisher"
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://downloads.nordcdn.com/apps/windows/10/NordVPN/latest/NordVPNSetup.exe'
  softwareName   = 'NordVPN*'
  checksum       = '808C9BEFEC363CE9D9DC7A67A85063A14E7686DAAF9E3CFDBC41C6CD5FE63A5DD6A2A0E3423BFB49250469E16A851D3711BEA14BC14DD58FB089D39D122596BC'
  checksumType   = 'sha512'
  silentArgs     = "/SILENT /SUPPRESSMSGBOXES /NORESTART /SP- /ALLUSERS /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName)\$($env:chocolateyPackageVersion)\install.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
