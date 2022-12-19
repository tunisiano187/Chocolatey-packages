$packageName = 'initool'
$url = 'https://github.com/dbohdan/initool/releases/download/v0.9.0/initool-v0.9.0-win32.zip'
$checksum = '16a9296d1e47d372676dc0d2cb0f2cc1df8c62c14ef8f9aafa3321e9f2f448f9'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"