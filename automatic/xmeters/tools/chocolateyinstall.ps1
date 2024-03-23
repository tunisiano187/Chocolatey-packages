$ErrorActionPreference = 'Stop';
$url        = 'https://entropy6.com/xmeters/downloads/XMetersSetup.exe'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'xmeters'
  checksum 		= '7E88AC356DBCF8B33A17D52AB0178EA516471E7BC4D7D1C9814104FD74D584B3'
  checksumType  = 'sha256'
  silentArgs    = "/S"
  validExitCodes = @(0, 1116, 1641, 3010)
  
}

Install-ChocolateyPackage @packageArgs
