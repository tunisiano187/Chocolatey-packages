$url          = 'https://h2database.com/h2-setup-2019-10-14.exe'
$checksum     = ''
$checksumType = ''

$packageArgs  = @{
  packageName   	= $env:ChocolateyPackageName
  fileType      	= 'EXE'
  softwareName  	= "$env:ChocolateyPackageName*"
  url             = $url
  checksum        = $checksum
  checksumType    = $checksumType
  silentArgs    	= '/S'
  validExitCodes	= @(0)
}

Install-ChocolateyPackage @packageArgs
