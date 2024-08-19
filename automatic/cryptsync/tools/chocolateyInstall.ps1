$packageName        = $env:ChocolateyPackageName
$installerType      = 'msi'
$silentArgs         = '/quiet /qn /norestart'
$url32              = 'https://github.com/stefankueng/CryptSync/releases/download/1.4.10/CryptSync-1.4.10.msi'
$Checksum32         = '9a439c7f692eb69732c1c57946414c3ed483483c661c9edf8102155ccde39c24'
$checksumType32     = 'sha256'
$url64              = 'https://github.com/stefankueng/CryptSync/releases/download/1.4.10/CryptSync64-1.4.10.msi'
$checksum64         = 'c0f2fbac7e17b1cb687523bd257d0dd7ff51acb40f308f0f6544c112e0bb75e7'
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
