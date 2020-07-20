$url			= 'https://www.odrive.com/downloaddesktop?platform=win'
$checksum		= '8be93da59a14e60ab86b9bc443c0fe5a7377573e37d92067ffd2d503a4510423'
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
