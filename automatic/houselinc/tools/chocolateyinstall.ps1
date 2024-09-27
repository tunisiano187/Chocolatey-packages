$ErrorActionPreference = 'Stop'
$packageName   = 'houselinc'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'http://cache.insteon.com/downloads/HouseLincSetup.zip'
$UnzippedMSI  = Join-Path $toolsDir 'HouseLincSetup.msi'
$installerType = 'MSI'
$silentArgs    = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  url64bit		= $url
  checksum      = '5E374773ECE2AFF5B7F342DB76E0F27F4FDCD05F577D8A955D7DB0E2F44E6B05'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $UnzippedMSI
  SilentArgs    = $silentArgs
  ValidExitCodes= $validExitCodes
  checksum      = 'A7311A9B93054C70B8780D3B0542B711005F1EC5F0276EF02DD7426A817CBC14'
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs

Start-Sleep -s 30

#if((get-process "msiexec" -ea SilentlyContinue) -eq $Null){
#    Write-Host "msiexec currently NOT running."
#  }else{
#    Write-Host "Stopping msiexec process..."
#    Stop-Process -processname "msiexec"
#  }

