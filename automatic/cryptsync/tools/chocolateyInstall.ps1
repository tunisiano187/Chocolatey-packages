$packageName        = $env:ChocolateyPackageName
$installerType      = 'msi'
$silentArgs         = '/quiet /qn /norestart'
$url32              = 'https://github.com/stefankueng/CryptSync/releases/download/1.4.9/CryptSync-1.4.9.msi'
$Checksum32         = 'a78926a062aaedf2df92cdfd528725aef3a2faef14aee76b936cf3851bf537cd'
$checksumType32     = 'sha256'
$url64              = 'https://github.com/stefankueng/CryptSync/releases/download/1.4.9/CryptSync64-1.4.9.msi'
$checksum64         = '875aa07b6486151ef5b9f0ac04ad658d7d83d076e89d62a3d6eeda0e4863c727'
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
