$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.chrysocome.net/downloads/dd-0.5.zip'
$checksum       = '93bddcd8f24ab371e73ca08c7d9818b8a04c38953b32d01ee55ddcd97c583f59'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName $packageName `
                -url $url `
                -checksum $checksum `
                -checksumType $checksumType `
                -unzipLocation "$toolsDir" `
                -specificFolder ""
