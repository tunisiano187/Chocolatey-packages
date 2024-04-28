$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName

  url           = 'https://dl.acronis.com/s/ADM_en-US.exe'
  checksum      = 'A5ED9D1EFD8D56351B20468844562E1004658C40D6B3C1C021752CFA4599E1B2'
  checksumType  = 'sha256' 
  validExitCodes= @(1)
}

Start-Process "AutoHotKey" -Verb runas -ArgumentList "`"$toolsDir\chocolateyinstall.ahk`""
Install-ChocolateyPackage @packageArgs