$ErrorActionPreference = 'Stop'
$packageName= 'amiduos' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.amiduos.com/installer/wcr/DuOSInstaller.exe'
$validExitCodes= @(0)
$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "amiduosinstall.ahk"
$ahkProc = Start-Process -FilePath $ahkExe `
                         -ArgumentList $ahkFile `
                         -PassThru

$ahkId = $ahkProc.Id
Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$ahkId"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  softwareName  = 'DuOS*' 
  checksum      = 'EA2247B49E6DFE6D6E8D02A51DB709E83CCD3BFB915C9BB555BBB41C0EAC2BEF'
  checksumType  = 'sha256'  
  validExitCodes= $validExitCodes
  }
  
Install-ChocolateyPackage @packageArgs

Start-Sleep -s 20
if((get-process "DuOSInstaller" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "DuOSInstaller NOT running." 
  }else{ 
    Write-Host "Stopping DuOSInstaller process..."
    Stop-Process -processname "DuOSInstaller"
  }

if((get-process "AndServMgr" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "AndServMgr currently NOT running." 
  }else{ 
    Write-Host "Stopping AndServMgr process..."
    Stop-Process -processname "AndServMgr"
  }