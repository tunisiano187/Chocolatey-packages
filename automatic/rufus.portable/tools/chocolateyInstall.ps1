$packageName    = $env:ChocolateyPackageName

$url            = 'https://github.com/pbatard/rufus/releases/download/v4.4/rufus-4.4p.exe'
$checksum       = '42cdb16f6dd64c4fec30c7a71960fe4d0015862c37e7b02c8dba5c0d68384c74'
$checksumType   = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile    = Join-Path $toolsDir "rufusp.exe"

$packageArgs = @{
  packageName   = $packageName
  FileFullPath  = $installFile
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

try {
  Get-ChocolateyWebFile @packageArgs
  Set-Content -Path ("$installFile.gui") `
              -Value $null
} catch {
  throw $_.Exception
}
