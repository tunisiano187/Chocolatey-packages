$packageName = 'emeditor'
$version     = '26.0.3'
$fileType    = 'msi'
$installArgs = '/quiet /norestart'
$url64       = 'https://emeditor.blob.core.windows.net/emed64_26.0.3.msi'
$checksum64  = '2762ee07156cbc2ad274aa62fe82e701cd6736182eac44c529eae98eb6bc5221'

Install-ChocolateyPackage $packageName $fileType $installArgs `
    -url64bit $url64 `
    -checksum64 $checksum64 `
    -checksumType64 'sha256'
