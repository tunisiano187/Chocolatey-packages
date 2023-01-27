$ErrorActionPreference = 'Stop'

$packageName    = 'Compressonator-cli'
$url64          = 'https://github.com/GPUOpen-Tools/compressonator/releases/download/V4.3.206/CompressonatorCLI_x64_4.3.206.exe'
$checksum64     = '15513ad190cf92b149c343193bd7c96c07307a4d6c4d71c516c906d039e1d638'
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
