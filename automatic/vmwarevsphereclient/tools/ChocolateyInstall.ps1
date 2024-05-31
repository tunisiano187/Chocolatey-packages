$ErrorActionPreference = 'Stop'
# Download URLs for VMware vSphere Client (2089791)
# https://kb.vmware.com/s/article/2089791
$packageName    = 'vmwarevsphereclient' 
$url            = 'https://vsphereclient.vmware.com/vsphereclient/9/1/0/3/8/9/1/VMware-viclient-all-6.0.0-9103891.exe'
$checksum       = 'D37203F2344E44016501FB269E92D5FAC577B11FF319C3C653ED5D762F82DE64'
$silentArgs     = '/s /w /v" /qb"' 
$validExitCodes = @(0) 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'VMware vSphere Client 6*'
  checksum      = $checksum 
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
