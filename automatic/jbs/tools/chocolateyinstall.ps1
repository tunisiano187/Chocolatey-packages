$ErrorActionPreference  = 'Stop'
$url                    = 'https://dl.johnsadventures.com/SwitcherSetup62.exe'
$checksum               = '689bc815219a185d1d89ea6e007efd5c34c512e7e7b9259de1e1e8815864f27d'
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
