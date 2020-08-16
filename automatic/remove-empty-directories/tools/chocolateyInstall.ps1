$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/hxseven/Remove-Empty-Directories/archive/2.2.zip'
$checksum = 'e95969290d7987a469c93c07e4b01712909d4d859174b36365265b26a89a404e'
$checksumType = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                            -Url "$url" `
                            -UnzipLocation "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)" `
                            -Checksum "$checksum" `
                            -ChecksumType "$checksumType"
