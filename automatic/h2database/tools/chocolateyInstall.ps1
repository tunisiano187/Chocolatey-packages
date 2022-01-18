$url          = 'https://github.com/h2database/h2database/releases/download/version-2.1.210/h2-setup-2022-01-17.exe'
$checksum     = '36759d154dd91a1363dda2d41dfa051cafa732f7a1e4fa2216ae8a021196d3b3'
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
