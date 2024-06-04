$ErrorActionPreference = 'Stop'
$packageName    = 'neat'
$url            = 'https://s3.amazonaws.com/legacy-installers/latest/Neat_v5.7.1.474_FULL.sfx.exe'
$checksum       = '19E5C4A1351B948FA6E140AFEF8BD6C0A605BF41032DA5AFDF196E6E34979616'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$realInstaller  = 'Neat v5.7.1 FULL.exe'
 
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP'
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}
 
Install-ChocolateyZipPackage @packageArgs

# Make sure Print Spooler service is up and running stolen from cutepdf package.
try {
  $serviceName = 'Spooler'
  $spoolerService = Get-WmiObject -Class Win32_Service -Property StartMode,State -Filter "Name='$serviceName'"
  if ($spoolerService -eq $null) { throw "Service $serviceName was not found" }
  Write-Host "Print Spooler service state: $($spoolerService.StartMode) / $($spoolerService.State)"
  if ($spoolerService.StartMode -ne 'Auto' -or $spoolerService.State -ne 'Running') {
    Set-Service $serviceName -StartupType Automatic -Status Running
    Write-Host 'Print Spooler service new state: Auto / Running'
  }
} catch {
  Write-Warning "Unexpected error while checking Print Spooler service: $($_.Exception.Message)"
}
 
$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $unzipLocation + "\" + '$OUTDIR' + "\" + $realInstaller
  silentArgs    = '/S'
  validExitCodes= @(0, 3010, 1641)
  softwareName  = 'Neat*'
}
  
Install-ChocolateyInstallPackage @packageArgs
 
Remove-Item $unzipLocation -Recurse | Out-Null
