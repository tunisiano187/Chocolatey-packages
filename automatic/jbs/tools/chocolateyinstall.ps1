$ErrorActionPreference  = 'Stop'
$url                    = 'https://dl.johnsadventures.com/SwitcherSetup61.exe'
$checksum               = '0167cb69bfc7930ebc7e89e77cef6d8d737e4813640c0a9bec429e37bc79ad19'
$checksumType           = 'sha256'

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    fileType        = 'EXE'
    url             = $url
    softwareName    = 'john*'
    checksum        = $checksum
    checksumType    = $checksumType
    silentArgs      = '/S'
    ValidExitCodes  = @(0,1223)
  }

Install-ChocolateyPackage @packageArgs
