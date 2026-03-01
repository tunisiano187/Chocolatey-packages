$packageName    = 'emeditor'
$fileType       = 'msi'
$installArgs    = '/quiet /norestart'
$url64          = 'https://emeditor.blob.core.windows.net/emed64_PLACEHOLDER_VERSION.msi'
$checksum64     = 'PLACEHOLDER_CHECKSUM64'
$checksumType64 = 'sha256'

Install-ChocolateyPackage $packageName $fileType $installArgs `
    -url64bit       $url64 `
    -checksum64     $checksum64 `
    -checksumType64 $checksumType64
