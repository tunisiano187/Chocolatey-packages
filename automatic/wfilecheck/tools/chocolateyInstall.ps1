$url            = 'https://sourceforge.net/projects/whirlpoolfilech/files/0.5/WFileCheck32.exe/download'
$checksum       = 'abc1caf8cbb79595a973044e63c39a785432e4aa93441199ebbd6d397485e0d1'
$checksumType   = 'sha256'
$url64          = 'https://sourceforge.net/projects/whirlpoolfilech/files/0.5/WFileCheck64.exe/download'
$checksum64     = '573801efc6a293a91764aa19bf32eac4064687fd83baf254784546289647115f'
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
