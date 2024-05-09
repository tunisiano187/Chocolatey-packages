$ErrorActionPreference  = 'Stop'
$url                    = 'https://dl.johnsadventures.com/SwitcherSetup58.exe'
$checksum               = 'b412edcdfb873329a894a7950e9330002f774e5c6d512244d7bc564503063e68'
$checksumtype           = 'sha256'

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