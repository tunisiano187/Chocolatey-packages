$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url64          = 'https://github.com/GPUOpen-Tools/compressonator/releases/download/V4.1.5083/CompressonatorCLI_x64_4.1.5083.exe'
$checksum64     = '372c56777a56d41720c85d494cbfa1ef8b4c62b4752643be7f82e08784668ee6'
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
