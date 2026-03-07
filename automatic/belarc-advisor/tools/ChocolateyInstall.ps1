$packageName    = 'belarc-advisor'
$url            = 'https://www2.aomeisoftware.com/download/adb/ABServerTrial.exe'
$checksum       = 'FCA81EC6930922351FB98C429D76164A0D82152F9BBE5D2E92F500CA83C43352'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  softwareName  = "$packageName*"
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs    = '/S'
  validExitCodes= @(0,1)
}

Install-ChocolateyPackage @packageArgs


