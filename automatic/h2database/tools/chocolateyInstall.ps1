$url          = 'https://github.com/h2database/h2database/releases/download/version-2.0.206/h2-setup-2022-01-04.exe'
$checksum     = '7a47f677683ac5d6787db2c91a6125a978b5f692869c18eacdb4584a43cfa820'
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
