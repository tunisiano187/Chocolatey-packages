$ErrorActionPreference = 'Stop'

$packageName    = 'Compressonator-cli'
$url64          = 'https://github.com/GPUOpen-Tools/compressonator/releases/download/V4.5.52/CompressonatorCLI_x64_4.5.52.exe'
$checksum64     = '1159f5db652b5f8e3a50083248fdf8f958de26d18dc8516bf4cf8fdd0f89d744'
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
