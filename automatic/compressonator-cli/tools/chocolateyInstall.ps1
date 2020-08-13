$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url64          = 'https://github.com//WinMerge/winmerge/releases/download/2.16.7/WinMerge-2.16.7-x64-Setup.exe'
$checksum64     = 'cba99e028100dcbd3f55d92ec8b374c79a429c3344bf63a53bef119ecbc545ae'
$checksumType64 = ''

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
