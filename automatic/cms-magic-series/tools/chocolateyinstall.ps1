$ErrorActionPreference = 'Stop'
$packageName    = 'cms-magic-series'
$installerType  = 'MSI'
$url            = 'https://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS%23unix-IPT%232.5.6.2076-win32.msi'
$checksum       = '420f5bce886183f6507b855ee2b945e251e158a6080251afdb6ff3447b69c0fd'
$checksumType   = 'sha256'
$url64          = 'https://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS%23unix-IPT%232.5.6.2076-win64.msi'
$checksum64     = '91febca1410851d43a653fd361c03e46ef8b1facdf65f8f8becef8107b369252'
$checksumType64 = 'sha256'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'CMS'
  checksum      = $checksum
  checksumType  = $checksumType
  checksum64    = $checksum64
  checksumType64= $checksumType64
}

Install-ChocolateyPackage @packageArgs
