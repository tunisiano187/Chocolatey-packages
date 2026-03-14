$packageName    = 'belarc-advisor'
$url            = 'https://downloads.belarc.com/advisor/advisorinstaller.exe'
$checksum       = '47EA898493F64ED818EDF9B76B0B0E047D753C3E1EBCFB70E251563D4212E56F'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  softwareName  = "$packageName*"
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs    = '/S'
  validExitCodes= @(0,1)
}

Install-ChocolateyPackage @packageArgs


