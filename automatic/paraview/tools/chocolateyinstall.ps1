$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v6.0/&type=binary&os=Windows&downloadFile=ParaView-6.0.1-Windows-Python3.12-msvc2017-AMD64.msi' # download url, HTTPS preferred
$checksum       = '928603549B9BE2B787FA2D507E00B7BC84B361BBF5E3C6A15765DD4836D9A2DA'
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
