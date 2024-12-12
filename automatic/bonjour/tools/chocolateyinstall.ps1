$ErrorActionPreference = 'Stop';

$url              = 'https://www.apple.com/itunes/download/win32'
$checksum         = '145a32239b2da5048920f46367fdc672daa91c66cbfbff039678b0e878791d3f'
$checksumType     = 'SHA256'

$url64            = 'https://www.apple.com/itunes/download/win64'
$checksum64       = '9cbaef01a8e2be6f4aa68768484268def7ca71491b71e56b435d4878da3232fd'
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
