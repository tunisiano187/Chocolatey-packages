$url          = 'https://github.com/h2database/h2database/releases/download/version-2.0.204/h2-setup-2021-12-21.exe'
$checksum     = '88b0113452b93633dc0fe5dc521223387f00879f9a2a5a7ea53eb8ccb163407f'
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
