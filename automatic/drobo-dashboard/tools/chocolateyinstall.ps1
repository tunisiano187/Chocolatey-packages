$ErrorActionPreference = 'Stop'
$packageName = 'drobo-dashboard'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe      = 'AutoHotKey'
$url         = 'https://files.drobo.com/webrelease/dashboard/drobodashboardinstaller_3.5.0.exe'
$checksum    = 'C15DE5BC66FE395E94F9962D0C1AE6512DA89090DC46D73735E40FE0733321EA'


$PreviouslyInstalled = (Test-Path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{863885B3-7C05-421C-8817-568712778745}")
If ($PreviouslyInstalled -eq $True){
	Write-Host " ** Uninstalling previous version of Drobo Dashboard" -ForegroundColor Magenta
	Start-CheckandStop "Drobo Dashboard"
	Start-CheckandStop "DDAssist"

    $packageArgs = @{
      packageName   = $packageName
      fileType      = 'MSI'
      silentArgs    = '{863885B3-7C05-421C-8817-568712778745}'
      softwareName  = 'Drobo Dashboard'
    }

    $ahkFile = "$toolsDir\drobo-dashboard_uninstall.ahk"
    Start-Process $ahkExe $ahkFile
    Uninstall-ChocolateyPackage @packageArgs
}

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = ''
  softwareName  = 'Drobo Dashboard'
  }

$ahkFile = "$toolsDir\drobo-dashboard_install.ahk"
Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs

If ($PreviouslyInstalled -eq $True){
   if ($ProcessWasRunning -eq "True") {&"$ProcessFullPath"}
   }
