$url			= 'https://www.odrive.com/downloaddesktop?platform=win'
$checksum		= '08fff4a119143923e1d53a70fce8e4a9e24d42b6c004916bf2056e01a4fd3f0c'
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
