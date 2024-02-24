$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.6&type=binary&os=Windows&downloadFile=ParaView-5.6.1-Windows-msvc2015-64bit.exe' # download url, HTTPS preferred
$checksum       = ''
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'MSI'
  url           = $url
  softwareName  = 'paraview*' 
  checksum      = '7E755DC7E6D3F0A4DC130BEC8D2C512E2A5A9457E3A02AFFD934CE56B650C9C0'
  checksumType  = 'sha256' 
  
  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs