$url			= 'https://www.odrive.com/downloaddesktop?platform=win'
$checksum		= 'f32dc461560261ee06c9064bd9eedf74827f8c4aab6edfdc3a2de5cef6f472a5'
$packageArgs = @{
  packageName   = 'odrive'
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
