$url          = 'http://www.h2database.com/h2-setup-2012-07-13.exe'
$checksum     = ''
$checksumType = ''

$packageArgs  = @{
  fileType      	= 'EXE'
  url             = $url
  checksum        = $checksum
  checksumType    = $checksumType
  silentArgs    	= '/S'
  validExitCodes	= @(0)
}

Install-ChocolateyPackage $packageArgs