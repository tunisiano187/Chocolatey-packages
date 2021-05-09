$packageName = 'pngquant'
$url = 'https://pngquant.org/pngquant-windows.zip'
$checksum = 'ec6aaa7841e142f12140c139187922f9f216c2397eebc7b14459cab6591e6dfc'
$checksumType = 'sha256'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Install-ChocolateyZipPackage -PackageName $packageName `
                             -Url $url `
                             -UnzipLocation $toolsDir `
                             -Checksum $checksum `
                             -ChecksumType $checksumType

Write-Verbose "Creating .ignore sidecar files for .bat filetype to prevent shims"
$files = Get-ChildItem $toolsDir -Include *.bat -Recurse
foreach ($file in $files) {
  New-Item "$file.ignore" -ItemType file -Force | Out-Null
}

