﻿$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.12/&type=binary&os=Windows&downloadFile=ParaView-5.12.0-RC3-Windows-Python3.10-msvc2017-AMD64.msi' # download url, HTTPS preferred
$checksum       = 'f20c996478662d95f9ddcf81960073f7e9da3a04689922b832c0ade2af656925'
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

Install-ChocolateyPackage @packageArgs
