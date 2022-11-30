$packageName = $env:ChocolateyPackageName
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$checksum         = ''
$checksumType     = ''
$checksum64       = ''
$checksumType64   = ''

$packageArgs = @{
  packageName     = $packageName
  fileType        = 'EXE'
  silentArgs      = '-q'
  file            = Get-Item $toolsPath\*_x86.exe
  file64bit		    = Get-Item $toolsPath\*_x64.exe
  checksum 		    = $checksum
  checksumType 	  = $checksumType
  checksum64      = $checksum64
  checksumType64  = $checksumType64
}

Install-ChocolateyPackage @packageArgs
