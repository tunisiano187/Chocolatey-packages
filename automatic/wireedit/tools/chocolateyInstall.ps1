$installerType  = 'msi'
$url            = 'https://wireedit.com/WireEditiWin7-0.11.430.msi'
$silentArgs     = '/quiet'
$checksum       = '2f8da7b55fb65c308b7c7773b21cdb8422cc5215692078720f2d265a1e7b19d8'
$checksumType   = ''

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = $installerType
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs    = $silentArgs
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs