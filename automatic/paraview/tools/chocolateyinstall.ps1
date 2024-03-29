﻿$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.12/&type=binary&os=Windows&downloadFile=ParaView-5.12.0-Windows-Python3.10-msvc2017-AMD64.msi' # download url, HTTPS preferred
$checksum       = '0d68554c75c9b9454993c2e4001649b92253e62d3147af01e6fd8ab341c07f8d'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'MSI'
  url           = $url
  softwareName  = 'paraview*'
  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs    = "/quiet /qn /norestart"
  validExitCodes= @(0, 3010, 1641)
}

if((Get-CimInstance -ClassName Win32_OperatingSystem).ProductType -eq 1) {
  Install-ChocolateyPackage @packageArgs
} else {
  Write-Warning "System not supported, client required"
  exit 0;
}
