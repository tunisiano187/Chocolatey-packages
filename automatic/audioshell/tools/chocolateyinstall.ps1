$ErrorActionPreference = 'Stop'

$packageName    = 'audioshell'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url            = 'http://www.softpointer.com/downloads/AudioShell236.exe'
$checksum       = '0EB44EF06A4EBD8FAA919DD59CFC692974209EF804586491FE6BC9B10965067B'
$checksumType   = 'sha256'
$validExitCodes = @(0)
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\audioshell.ahk"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Audioshell*'
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Start-Process $ahkExe $ahkFile

Install-ChocolateyPackage @packageArgs
