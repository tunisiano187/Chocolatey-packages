$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName  = 'vibrancegui' # arbitrary name for the package, used in messages
$url          = 'http://vibrancegui.com/vibrance/download' # download url
$checksum     = 'b2560705a8647cb8931097b32638049c1388e7e0'
$checksumType = 'sha1'

Install-ChocolateyZipPackage $packageName `
  -Url $url `
  -Checksum $checksum `
  -ChecksumType $checksumType `
  -UnzipLocation "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
