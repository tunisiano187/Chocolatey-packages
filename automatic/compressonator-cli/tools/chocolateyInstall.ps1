$ErrorActionPreference = 'Stop'

$packageName    = 'Compressonator-cli'
$url64          = 'https://github.com/GPUOpen-Tools/compressonator/releases/download/V4.4.19/CompressonatorCLI_x64_4.4.19.exe'
$checksum64     = '3912a715138deba05d79c99045c8b4c12d685042fd4cec58df493102cb814827'
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
