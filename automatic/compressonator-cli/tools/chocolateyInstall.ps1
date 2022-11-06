$ErrorActionPreference = 'Stop'

$packageName    = 'Compressonator-cli'
$url64          = 'https://github.com/GPUOpen-Tools/compressonator/releases/download/V4.2.5185/CompressonatorCLI_x64_4.2.5185.exe'
$checksum64     = '89bd8d9704b4d2890aba50928ec57ce3b9c3f1dd05ce572a2058d0f738ff1f5e'
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
