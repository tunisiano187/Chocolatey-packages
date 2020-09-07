$url          = 'https://h2database.com/h2-setup-2019-10-14.exe'
$checksum     = '4be542c45c2a68867b0f929443a3245ed20b24c07ec251bc7a802f31f3779624'
$checksumType = 'sha256'

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
