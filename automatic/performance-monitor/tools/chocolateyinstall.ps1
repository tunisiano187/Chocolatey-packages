$packageName    = 'performance-monitor' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.hexagora.com/download/PerfMon.zip'
$checksum       = '75D30013EF5FF769020B3198228A2A5E6E4653173A3E7F194E2B94ED1E67B27C'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
$fileName       = 'PerfMon4x.exe'
$fileLocation   = Join-Path $toolsDir $fileName

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

if((get-process "PerfMon" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "PerfMon currently NOT running." 
  }else{ 
    Write-Host "Stopping PerfMon process..."
    Stop-Process -processname "PerfMon"
  }
  
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = $silentArgs
  validExitCodes = $validExitCodes
  softwareName   = 'Performance Monitor 4*'
}

Install-ChocolateyInstallPackage @packageArgs