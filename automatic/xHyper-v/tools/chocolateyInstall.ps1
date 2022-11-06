$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/dsccommunity/HyperVDsc/archive/refs/tags/v3.18.0.zip'
$checksum       = '042b51dabc3bab2e9bb585be4f8b529ae76fd17d12378c9be71037720da90a36'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName $packageName `
                    -url $url `
                    -checksum $checksum `
                    -checksumType $checksumType `
                    -unzipLocation "$toolsDir" `
                    -specificFolder ""

$moduleManifest = Get-ChildItem $toolsDir -filter *.psd1 -Recurse

Install-Module -modulename ([io.path]::GetFileNameWithoutExtension($moduleManifest)) -modulepath $moduleManifest.Parent.FullName -global -force
