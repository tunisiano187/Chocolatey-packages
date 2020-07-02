$url			= 'https://www.odrive.com/downloaddesktop?platform=win'
$checksum		= 'ca53a944a5f6dcdfd408e7d5782819e71cc4b040a03b8dce11fda06eb10afae5'
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
