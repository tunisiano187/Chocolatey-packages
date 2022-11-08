$packageName        = $env:ChocolateyPackageName
$installerType      = 'msi'
$silentArgs         = '/quiet /qn /norestart'
$url32              = ''
$Checksum32         = '441c7f1427d7e8b0bd37c1625657ac7f845dfec990fa2b5499dd7b753d784240'
$checksumType32     = 'sha256'
$url64              = ''
$checksum64         = 'b702e6cf3e01e7bcfbf591d62d6dc0cafc9b7843ab41f2d4a30651fab096aade'
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