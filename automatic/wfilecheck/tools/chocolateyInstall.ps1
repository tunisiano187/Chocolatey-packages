$url            = ''
$checksum       = '6beca15e394d9c2070614145b97a972f9ec0c66d286a62e3120c5772fcd3628e'
$checksumType   = 'sha256'
$url64          = ''
$checksum64     = '934087fafb8de7776cc79da395dc4329680fbbb033efea3e415c28bfe90dcdec'
$checksumType64 = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile    = Join-Path $toolsDir "$($packageName).exe"

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  FileFullPath    = $installFile

  url             = $url
  checksum        = $checksum
  checksumType    = $checksumType

  url64bit        = $url64
  checksum64      = $Checksum64
  checksumType64  = $ChecksumType64
}

try {
  Get-ChocolateyWebFile @packageArgs
  
  Set-Content -Path ("$installFile.gui") `
              -Value $null
} catch {
  throw $_.Exception
}
