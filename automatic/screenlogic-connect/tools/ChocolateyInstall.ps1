$ErrorActionPreference = 'Stop'
$packageName    = 'screenlogic-connect'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.pentair.com/content/dam/extranet/nam/pentair-pool/residential/software-firmware/screenlogic/setup.exe'
$checksum       = '6DEABE14ACD64F1ECEEA6677AB0E8AABFE99C80B2A1717B3F3A2E9BE583A70DA'

$packageArgs = @{
  packageName  = $packageName
  FileFullPath = "$toolsDir\pentairupdate.exe"
  url          = 'https://www.pentair.com/content/dam/extranet/nam/pentair-pool/residential/software-firmware/screenlogic/pentairupdate.exe'
  checksum     = 'BC3A19B1B01A0D0AEEDFDC85584EF77B6A8ED783E0D0BEFEB4F3291761AFA3BA'
  checksumType = 'sha256'
}

Write-Host "  ** Downloading Protocol Adapter firmware update program v5.2 Build 738.0 Rel. (03/26/19) for manual installation." -Foreground Magenta
Get-ChocolateyWebFile @packageArgs

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0,1)
  silentArgs     = '/quiet'
  softwareName   = 'Pentair ScreenLogic'
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs
