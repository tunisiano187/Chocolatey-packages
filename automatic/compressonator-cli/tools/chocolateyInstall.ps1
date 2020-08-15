$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url64          = 'https://github.com/GPUOpen-Tools/compressonator/releases/download/V4.0.4855/CompressonatorCLI_x64_4.0.4855.exe'
$checksum64     = 'a82cc06f06068440afea1ecdfda81750b10a1fbfac4814a6f7161efddf52236a'
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
