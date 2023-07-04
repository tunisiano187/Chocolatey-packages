$url          = 'https://github.com/h2database/h2database/releases/download/version-2.2.220/h2-setup-2023-07-04.exe'
$checksum     = 'e7632a3e08c4aa366367c77bf39ad1097f99d2ad200aceb9f482b1ac2501a968'
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
