$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/dsccommunity/xHyper-V/archive/v3.17.0.zip'
$checksum       = 'df8819d8b48ce9d1058b18605a5c22cbb58a0817bfa9f29d7fcc7b3fdf164800'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName $packageName `
                    -url $url `
                    -checksum $checksum `
                    -checksumType $checksumType `
                    -unzipLocation "$toolsDir" `
                    -specificFolder ""

$moduleManifest = Get-ChildItem $toolsDir -filter *.psd1 -Recurse

Install-Module -modulename ([io.path]::GetFileNameWithoutExtension($moduleManifest)) -modulepath $moduleManifest.Parent.FullName -global -force
