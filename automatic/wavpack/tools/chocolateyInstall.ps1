$packageName    = 'wavpack'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/dbry/WavPack/releases/download/5.9.0/wavpack-5.9.0-x86.zip'
$checksum       = '4e960c95a4ca80e380d5317880cec6bb3250e7e4ca714d43b61294fe90d9b06b'
$checksumType   = 'sha256'
$url64          = 'https://github.com/dbry/WavPack/releases/download/5.9.0/wavpack-5.9.0-x64.zip'
$checksum64     = 'ad5e94bcde6f4edfc859210d98f144f225805a391c633c68f6dbb15a9e52570e'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -Url64bit "$url64" `
                             -Checksum64 "$checksum64"`
                             -ChecksumType64 "$checksumType"
