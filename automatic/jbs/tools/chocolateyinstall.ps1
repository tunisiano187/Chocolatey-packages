$ErrorActionPreference  = 'Stop'
$url                    = 'https://dl.johnsadventures.com/SwitcherSetup60.exe'
$checksum               = '40a48f1a14ef9ac75a32b8aea373f3a3a6440eba0344d91d69dd65a83adbc7e2'
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
