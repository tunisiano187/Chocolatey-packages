$packageName        = $env:ChocolateyPackageName
$installerType      = 'msi'
$silentArgs         = '/quiet /qn /norestart'
$url32              = 'https://github.com/stefankueng/CryptSync/releases/download/1.4.3/CryptSync-1.4.3.msi'
$Checksum32         = '19f9494ee519aace90c94f036e865b5717bcb5d9d01dd92e929330c406e266b0'
$checksumType32     = 'sha256'
$url64              = 'https://github.com/stefankueng/CryptSync/releases/download/1.4.3/CryptSync64-1.4.3.msi'
$checksum64         = '879d015c9a2bf3dc7df386befbd5bf0bcb19d5e70f8b614ae592e22a2316dca7'
$checksumType64     = 'sha256'
$validExitCodes     = @(0)

$packageArgs = @{
  packageName       = $packageName
  FileType          = $installerType
  url               = $url32
  Checksum          = $checksum32
  ChecksumType      = $checksumType32
  url64             = $url64
  Checksum64        = $checksum64
  ChecksumType64    = $checksumType64
  softwareName      = "$packageName*"
  ValidExitCodes    = $validExitCodes
}

Install-ChocolateyPackage @packageArgs
