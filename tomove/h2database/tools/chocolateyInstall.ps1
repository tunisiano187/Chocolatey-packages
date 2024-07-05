$url          = 'https://github.com/h2database/h2database/releases/download/version-2.2.224/h2-setup-2023-09-17.exe'
$checksum     = 'ff9931ddef1289fccc7d113738238a13f0a11b33216fbf82ae4ac77d569ac340'
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
