$url			= 'https://www.odrive.com/downloaddesktop?platform=win'
$checksum		= '7f5946906095411b1f8b43d4adcfe1c325f67f24b9a2fd2b6139d29bf3892fb2'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = $url
  silentArgs    = '/quiet'
  validExitCodes= @(0,3010)
  softwareName  = 'odrive*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs
