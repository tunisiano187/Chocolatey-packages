$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32      = 'https://software.lulzbot.com/Windows/Cura%20LulzBot%20Edition%204.13/4.13.8/Cura_LulzBot_Edition-4.13.8-amd64.exe'
$checksum32 = 'a3bccd5a7dfebbd1909fd1119baf9768d6b0c9f20ef8411bcc93d6c58a329f2d'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url32
  softwareName  = 'cura-lulzbot*'
  checksum      = $checksum32
  checksumType  = 'sha256'
  silentArgs   = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
