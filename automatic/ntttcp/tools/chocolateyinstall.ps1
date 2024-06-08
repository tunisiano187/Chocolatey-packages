$packageName  = 'ntttcp' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://gallery.technet.microsoft.com/NTttcp-Version-528-Now-f8b12769/file/159655/1/NTttcp-v5.33.zip'
$checksum     = '090FE61913513BD55A56E59354E50B0B1DDAB17721446345223D05DEDE4B8F0F'
$checksumType = ''
$file         = Join-Path $toolsDir $($url.Split('/')[-1])


$packageArgs = @{
  packageName   = $packageName
  FileFullPath  = $file
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Get-ChocolateyWebFile  @packageArgs