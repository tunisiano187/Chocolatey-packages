$packageName    = $env:ChocolateyPackageName

$url            = 'https://github.com/pbatard/rufus/releases/download/v4.5/rufus-4.5p.exe'
$checksum       = 'c6e6cdba209f899e5087f1a1a4babc759414b4a687b60ba4bce62b6b37e8e82b'
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
