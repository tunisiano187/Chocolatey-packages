$ErrorActionPreference = 'Stop'
$packageName    = 'hikvision-sadp'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://oversea-download.hikvision.com//uploadfile/Soft/Tools/SADP/for%20windows/V3.0.1.7/SADPTool.zip'
$checksum       = '0FD9185E2E12B1C696D1A9D4818F974CF82A5FE0A6C721C808A27AA74EF52223'

$packageArgs = @{
  packageName   = 'sadp'
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$toolsDir\SADPTool.exe"
  silentArgs     = "/s /f1$toolsDir\SADPTool.iss"
  validExitCodes = @(0)
  softwareName   = 'SADPTool'
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$toolsDir\SADPTool.*" -Force -EA SilentlyContinue | Out-Null
