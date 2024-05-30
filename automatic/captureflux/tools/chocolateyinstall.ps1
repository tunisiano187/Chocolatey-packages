$packageName  = 'captureflux' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://paul.glagla.free.fr/fichiers/captureflux_60en.zip'
$checksum     = '5CBD61413D72F15446B980F7A8AE5AC0D572A93BD3C103F11CC78032DC32F49C'
$checksumType = 'sha256'


$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyZipPackage @packageArgs


$exe = (Get-ChildItem -Path $toolsDir -Filter '*.exe').FullName

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  file          = $exe

  softwareName  = 'captureflux*'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs