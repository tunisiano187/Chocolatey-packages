$url          = 'https://github.com/h2database/h2database/releases/download/version-2.1.214/h2-setup-2022-06-13.exe'
$checksum     = '5a841a4ff6cd728713326e1e7e88f307be44f96469d33a5125713c154835403b'
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
