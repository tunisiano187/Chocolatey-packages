$packageName= 'tivo-desktop.install' 
$softwareName  = 'TiVo Desktop*'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://assets.tivo.com/assets/exe/tivotogo/TiVoDesktop2.8.3.exe'
$validExitCodes= @(0)
$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "TiVoDesktopinstall.ahk"
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
  silentArgs   = '' 
  softwareName  = $softwareName
  checksum      = 'A6522FDA0028FA4572A1BDAE8AEA0030B72C0E44598444E1D0F23520A2AC895E'
  checksumType  = 'sha256'  
  validExitCodes= $validExitCodes
  }
  
Install-ChocolateyPackage @packageArgs

if((get-process "TiVoDesktop" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "TiVoDesktop currently NOT running." 
  }else{ 
    Write-Host "Stopping TiVoDesktop process..."
    Stop-Process -processname "TiVoDesktop"
  }
