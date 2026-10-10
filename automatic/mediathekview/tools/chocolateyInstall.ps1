$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageName      = 'mediathekview'
$url32            = 'https://download.mediathekview.de/stabil/MediathekView-15.0.0-win.exe'
$checksum32       = '367f08e409435b98797cc20cea92249a7c12f86d0c71ddd3fc9aacec1f0fab04'
$checksumType32   = 'sha256'

$packageArgs = @{
  packageName     = $packageName
  fileType        = 'EXE'
  url             = $url32
  checksum        = $checksum32
  checksumType    = $checksumType32
  softwareName    = "$packageName*"
  # v15.0.0's installer is install4j (confirmed via its embedded strings -- "com/install4j/..."),
  # not the NSIS-style installer '/S' targets. install4j doesn't recognize '/S' at all, so the
  # installer opened its normal GUI wizard instead of running silently, and choco's verifier timed
  # out after 45 minutes waiting for a process that was sitting on an unattended prompt. '-q' is
  # install4j's own documented silent-install switch.
  silentArgs      = '-q'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
