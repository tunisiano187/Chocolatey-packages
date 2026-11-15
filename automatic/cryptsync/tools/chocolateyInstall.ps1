$packageName        = $env:ChocolateyPackageName
$installerType      = 'msi'
$silentArgs         = '/quiet /qn /norestart'
$url32              = 'https://github.com/stefankueng/CryptSync/releases/download/1.4.12/CryptSync-1.4.12.msi'
$Checksum32         = '382d064baec16b019bfdbcad5b75fa0eff8896add4399f1f3c314bdc66d73751'
$checksumType32     = 'sha256'
$url64              = 'https://github.com/stefankueng/CryptSync/releases/download/1.4.12/CryptSync64-1.4.12.msi'
$checksum64         = '7f3f26c7e7e9cc809482644c0781345aa3df8259b19801076654914ecc2f4e62'
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
