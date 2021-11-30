$url          = 'https://github.com/h2database/h2database/releases/download/version-2.0.202/h2-setup-2021-11-25.exe'
$checksum     = 'd8872a46d8a48d8205ac4d29bb3f25aa59f3c55d797fdb2b4eb9fa90b291c2da'
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
