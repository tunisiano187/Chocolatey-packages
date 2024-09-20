$ErrorActionPreference = 'Stop'
$packageName= 'audioshell'
$installerType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url        = 'http://www.softpointer.com/downloads/AudioShell236.exe'
$validExitCodes= @(0)
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "audioshell.ahk"
Start-Process $ahkExe $ahkFile
#$ahkProc = Start-Process -FilePath $ahkExe `
#                         -ArgumentList $ahkFile `
#                         -PassThru
#$ahkId = $ahkProc.Id
#Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
#Write-Debug "Process ID:`t$ahkId"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'Audioshell*' 
  checksum      = '0EB44EF06A4EBD8FAA919DD59CFC692974209EF804586491FE6BC9B10965067B'
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs

#Give time for all processes to finish
Start-Sleep 10



						  
						  
						  
						  
