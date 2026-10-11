$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/jonelo/jacksum-for-windows/releases/download/v2.11/jacksum-4.0.2-hashgarten-0.21.0-for-windows-2.11.0.zip'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksum = '243d340f081935dc742083a49450e8ac64f709b2542b38c1dab2fdd06e762415'
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
