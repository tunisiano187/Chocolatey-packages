$packageArgs = @{
  packageName   = 'odrive'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = 'https://www.odrive.com/downloaddesktop?platform=win'
  silentArgs    = '/quiet'
  validExitCodes= @(0,3010)
  softwareName  = 'odrive*'
  checksum      = '080B6EBD59F2ECE205BE811AF6BD0A74634BFE03'
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs