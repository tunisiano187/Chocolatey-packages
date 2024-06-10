$packageName  = 'ntttcp'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/microsoft/ntttcp/releases/download/v5.40/ntttcp.exe'
$checksum     = 'f66561d09af91305412fd60ca4b28d57c7b650035d3c1edcc00a57b079e2247e'
$checksumType = 'sha256'
$file         = Join-Path $toolsDir $($url.Split('/')[-1])


$packageArgs = @{
  packageName   = $packageName
  FileFullPath  = $file
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Get-ChocolateyWebFile  @packageArgs
