$packageName        = $env:ChocolateyPackageName
$installerType      = 'msi'
$silentArgs         = '/quiet /qn /norestart'
$url32              = 'https://github.com/stefankueng/CryptSync/releases/download/1.4.4/CryptSync-1.4.4.msi'
$Checksum32         = '80d8c510102807c78633c4a65b66b8908aa83ce016703dc78f54be0ef24399e5'
$checksumType32     = 'sha256'
$url64              = 'https://github.com/stefankueng/CryptSync/releases/download/1.4.4/CryptSync64-1.4.4.msi'
$checksum64         = '31e58498fab9421218cea0128602afaf09a89ee54c6f3650f2b84a18c370a636'
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
