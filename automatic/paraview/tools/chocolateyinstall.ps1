$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.13/&type=binary&os=Windows&downloadFile=ParaView-5.13.2-Windows-Python3.10-msvc2017-AMD64.msi' # download url, HTTPS preferred
$checksum       = '2793F88752AEE3B220DE57767F2837799978D548F3AA223611A7062D81B88193'
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
