$packageName = $env:ChocolateyPackageName
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/Pulover/PuloversMacroCreator/releases/download/v5.4.1/PuloversMacroCreator-Portable.zip'
$checksum = 'aebdf335913eae4270b585339727b44593a98d17d73a3aae80e4d46d27c01310'
$checksumType = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
