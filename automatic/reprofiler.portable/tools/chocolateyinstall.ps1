$ErrorActionPreference = 'Stop'
$packageName= 'reprofiler.portable'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "$toolsDir\Reprofiler2.zip"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = '057AD6768F4F757D52F01D5A77E5DAC898E031BFD29AA5C824C0623E068627A3'
  checksumType  = 'sha256'
}

Install-ChocolateyZIPPackage @packageArgs

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\ReProfiler(Portable).lnk" -targetPath "$env:ChocolateyInstall\lib\reprofiler.portable\tools\ReProfiler.exe"
Remove-Item $toolsDir\Reprofiler2.zip
