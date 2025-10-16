$packageName    = $env:ChocolateyPackageName

$url            = 'https://github.com/pbatard/rufus/releases/download/v4.11/rufus-4.11p.exe'
$checksum       = 'abbf04d50a44a9612c027fc8072f6da67f5bcda2b826f1f852c9c24d7a1fcdff'
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
