$packageName  = 'ntttcp'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/microsoft/ntttcp/releases/download/v5.40/ntttcp.exe'
$checksum     = 'F66561D09AF91305412FD60CA4B28D57C7B650035D3C1EDCC00A57B079E2247E'
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
