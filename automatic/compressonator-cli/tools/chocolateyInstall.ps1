$ErrorActionPreference = 'Stop'

$packageName    = 'Compressonator-cli'
$url64          = 'https://github.com/GPUOpen-Tools/compressonator/releases/download/V4.6.0/CompressonatorCLI_x64_4.6.0.exe'
$checksum64     = 'ab2f258b751c5705a00d367509b986c2d6f59aff8eea17c4f246ed34e0f849d1'
$checksumType64 = 'sha256'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url64bit               = $url64
  checksum64             = $checksum64
  checksumType64         = $checksumType64
  silentArgs             = "/qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes         = @(0)
}

Install-ChocolateyPackage @packageArgs
