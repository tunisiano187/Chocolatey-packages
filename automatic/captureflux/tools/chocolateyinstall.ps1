$packageName  = 'captureflux'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://paulglagla.com/fichiers/captureflux_63en.zip'
$checksum     = '3ccdd131c1320af39190bceefd3cc6bafa5425b546663d0fdb8f26993b0f4d37'
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

Install-ChocolateyInstallPackage @packageArgs
