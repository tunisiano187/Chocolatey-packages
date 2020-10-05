$packageName    = $env:ChocolateyPackageName

$url            = 'https://github.com/pbatard/rufus/releases/download/v3.11/rufus-3.11p.exe'
$checksum       = 'a43bf34285d393f843b05d80f74c4790ed7f6ac636393ca5f6375ae0bb02e719'
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
