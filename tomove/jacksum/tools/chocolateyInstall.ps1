$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/jonelo/jacksum-fbi-windows/releases/download/v2.8.0/jacksum-3.7.0-hashgarten-0.17.0-for-windows-2.8.0.zip'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksum = '2a9f115f23ac2715b767c9d9f812ee172f797a3ebb498a58ddcea8b36d2ee461'
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
