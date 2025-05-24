$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v6.0/&type=binary&os=Windows&downloadFile=ParaView-6.0.0-RC1-Windows-Python3.12-msvc2017-AMD64.msi' # download url, HTTPS preferred
$checksum       = '606D762A20B636693B047E4CD064D58CEB82EE42460DE7AC40F717EB0F50B52D'
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
