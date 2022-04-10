$url          = 'https://github.com/h2database/h2database/releases/download/version-2.1.212/h2-setup-2022-04-09.exe'
$checksum     = 'c1be4057ac0f795de510c03f7b529fb90a02ec64e041814a8ecec2c0ddcc5b06'
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
