$url          = 'https://github.com/h2database/h2database/releases/download/version-2.2.222/h2-setup-2023-08-22.exe'
$checksum     = 'c97d28216567459a4c1224aa132e251ff8a1ca111f22e6841b7c9bfcebad89d9'
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
