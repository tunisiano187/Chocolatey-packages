$packageName= 'tivo-desktop-patch' 
$softwareName  = 'TiVo Desktop*'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://assets.tivo.com/assets/exe/tivotogo/tivo-desktop-patch-setup.exe'
$validExitCodes= @(0)
$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "TiVoDesktopPatchinstall.ahk"
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
  checksum      = '863BF1FE3A547352687755BA6D1FFAFB418D44F51345095DE9B489BE7CB3D163'
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
