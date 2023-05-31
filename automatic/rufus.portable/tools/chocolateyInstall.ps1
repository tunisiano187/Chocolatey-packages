$packageName    = $env:ChocolateyPackageName

$url            = 'https://github.com/pbatard/rufus/releases/download/v4.1/rufus-4.1p.exe'
$checksum       = '8f680fdc6e91aff40066ecebdcfbe985a058313e6ddc024a9123fe0985493035'
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
