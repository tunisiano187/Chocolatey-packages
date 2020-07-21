$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/dsccommunity/xPSDesiredStateConfiguration/archive/v9.1.0.zip'
$checksum       = '72c9ac7aae5437abf226bb9b58be01dcb89710a575c1830172bab5ab2c47d208'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName $packageName `
                    -url $url `
                    -checksum $checksum `
                    -checksumType $checksumType `
                    -unzipLocation "$toolsDir" `
                    -specificFolder ""

$moduleManifest = Get-ChildItem $toolsDir -filter *.psd1 -Recurse

Install-Module -modulename ([io.path]::GetFileNameWithoutExtension($moduleManifest)) -modulepath $moduleManifest.Parent.FullName -global -force