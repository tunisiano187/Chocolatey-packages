$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'http://sourceforge.net/projects/rem-empty-dir/files/red-v2.2-portable.zip/download'
$checksum = 'c3dcaf87a336ea2bf71a6e183d8c7bae2923258a10586284ca23c985d2c688d5'
$checksumType = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                            -Url "$url" `
                            -UnzipLocation "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)" `
                            -Checksum "$checksum" `
                            -ChecksumType "$checksumType"
