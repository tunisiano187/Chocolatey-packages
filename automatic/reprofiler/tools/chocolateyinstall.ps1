$ErrorActionPreference = 'Stop'
$packageName= 'reprofiler'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "$toolsDir\Reprofiler2Setup.exe"
 
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  checksum      = '300749894539EC4AB6D6C2F79FD5924158B06E48AD55D34EDAD9725EDDB50C57'
  checksumType  = 'sha256'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName  = 'Reprofiler*'
}
 
Install-ChocolateyPackage @packageArgs
Remove-Item $toolsDir\Reprofiler2Setup.exe
