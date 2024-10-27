$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/jonelo/jacksum-for-windows/releases/download/v2.9.0/jacksum-3.7.0-hashgarten-0.18.0-for-windows-2.9.0.zip'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksum = '625ef84fb9310bd7c66f47776139c940d63ac7bcfb28ff31c6d1900310134fda'
$checksumType = 'sha256'

$packageArgs = @{
	packageName   = $env:ChocolateyPackageName
	unzipLocation = $toolsDir
	url           = $url
	checksum      = $checksum
	checksumType  = $checksumType
  }


Install-ChocolateyZipPackage @packageArgs

$file = (Get-ChildItem -Path $toolsDir -Include "*.exe" -Recurse).FullName

$packageArgs = @{
	packageName   = $env:ChocolateyPackageName
	fileType      = 'EXE'
	file          = $file
	softwareName  = 'Jacksum*'
	silentArgs   = '/S'
}

$ahkFile = Join-Path $toolsDir "chocolateyInstall.ahk"
$ahkExe = 'AutoHotKey.exe'
$ahkRun = "$Env:Temp\$(Get-Random).ahk"
Copy-Item $ahkFile "$ahkRun" -Force
Start-Process $ahkExe $ahkRun

Install-ChocolateyInstallPackage @packageArgs
