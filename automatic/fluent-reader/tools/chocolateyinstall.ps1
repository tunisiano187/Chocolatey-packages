$ErrorActionPreference = 'Stop' # stop on all errors

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url          = 'https://github.com/yang991178/fluent-reader/releases/download/v1.1.4/Fluent.Reader.Setup.1.1.4.x86.exe' # download url, HTTPS preferred
$checksum     = 'fa4cdcec8bf33aeff499d659ad0813c51455cfb0d57ea66f2c0dcc163828eb4f'
$url64        = 'https://github.com/yang991178/fluent-reader/releases/download/v1.1.4/Fluent.Reader.Setup.1.1.4.x64.exe' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
$checksum64   = '7ac520da69e03699a4355aae88d513a68fb297a946930c43a8c7dfc864cf4c64'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  url64bit      = $url64

  softwareName  = 'fluent-reader*' 

  checksum      = $checksum
  checksumType  = $checksumType 
  checksum64    = $checksum64
  checksumType64= $checksumType 

  validExitCodes= @(0, 3010, 1641)

  silentArgs   = '/S'           
}

Install-ChocolateyPackage @packageArgs
