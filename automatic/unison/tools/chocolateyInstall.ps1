$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bcpierce00/unison/releases/download/v2.53.2/unison-v2.53.2%2Bocaml-4.14.0%2Bmingw64c%2Bx86_64.windows.zip'
$checksum       = '33344676c2e78dbb9a1566b93e4312a175577181e72a1f4eb7081d3219e20b08'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
