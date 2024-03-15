$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/jonelo/jacksum-fbi-windows/releases/download/v2.6.0/jacksum-3.7.0-hashgarten-0.15.0-windows-explorer-integration-2.6.0.zip'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksum = '36b95119c3c87fb1ede8d4a664f3ca46739192662a96a4de07e39a1b24bff7d5'
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
