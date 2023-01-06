$checksum = 'f98661a0d4ebb9400537e74d18556acf7852d704e40a4e0fce69f337fafdb371'
$url = 'https://downloads.plex.tv/plex-media-server-new/1.30.0.6486-629d58034/windows/PlexMediaServer-1.30.0.6486-629d58034-x86.exe'

Start-CheckandStop "Plex Media Server"

$packageArgs = @{
  packageName   = 'plexmediaserver'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = $url
  silentArgs    = '/quiet'
  validExitCodes= @(0)
  softwareName  = 'plexmediaserver*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs

if ($ProcessWasRunning -eq "True") {&$ProcessFullPath}
