$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/jonelo/jacksum-fbi-windows/releases/download/v2.7.0/jacksum-3.7.0-hashgarten-0.16.0-windows-file-explorer-integration-2.7.0.zip'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksum = '458b306e300954feddfda399cc820384f917b387d8d817e4540af8f731e1a33e'
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
