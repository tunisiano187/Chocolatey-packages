$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/hxseven/Remove-Empty-Directories/releases/download/2.3-beta.0/red-v2.3-beta.0-portable-win64.zip'
$checksum = '311ca2e7aa51124bf004394d6d1495808270f831944e70d1f6ea1e0a240826bc'
$checksumType = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                            -Url "$url" `
                            -UnzipLocation "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)" `
                            -Checksum "$checksum" `
                            -ChecksumType "$checksumType"
