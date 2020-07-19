$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32      = ''

Install-ChocolateyZipPackage -PackageName $packageName `
                    -url $url32 `
                    -checksum $checksum `
                    -unzipLocation "$toolsDir" `
                    -specificFolder ""

$moduleManifest = Get-ChildItem $toolsDir -filter *.psd1 -Recurse

Install-Module -modulename ([io.path]::GetFileNameWithoutExtension($moduleManifest)) -modulepath $moduleManifest.Parent.FullName -global -force
