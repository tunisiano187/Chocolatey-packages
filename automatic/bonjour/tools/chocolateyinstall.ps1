$ErrorActionPreference = 'Stop';

$url              = 'https://secure-appldnld.apple.com/itunes12/072-08831-20241021-59E04F71-9D64-4CE7-978C-1A37574B78E4/iTunesSetup.exe'
$checksum         = 'a037a56e7535380dda167ff8d47d76295031d4c44fa87747ba199eb47b3bc641'
$checksumType     = 'SHA256'

$url64            = 'https://secure-appldnld.apple.com/itunes12/072-08832-20241021-5BCDE100-420E-4BEF-A8C7-16A8E499B7D3/iTunes64Setup.exe'
$checksum64       = 'b3d7c02032ae6ae3649914f70803e21f791b5399e2ff201fbcefad1dc059c192'
$checksumType64   = 'SHA256'

$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath     = "$toolsDir\itunes.zip"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  FileFullPath  = $fileFullPath

  url           = $url
  Checksum      = $checksum
  checksumType  = $checksumType

  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= $checksumType64

}

Get-ChocolateyWebFile @packageArgs
Get-ChocolateyUnzip -fileFullPath $fileFullPath -destination $toolsDir

$ignoreFilePath = Join-Path -Path $toolsDir -ChildPath "SetupAdmin.exe.ignore"
Set-Content -Path $ignoreFilePath -Value $null -ErrorAction SilentlyContinue

$bonjour = (Get-ChildItem -Path $toolsDir -Filter "Bonjour*.msi").FullName

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType		  = "msi"

  file          = $bonjour

  silentArgs	= "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-ChocolateyInstallPackage @packageArgs
