$ErrorActionPreference  = 'Stop'
$url                    = 'https://dl.johnsadventures.com/SwitcherSetup59.exe'
$checksum               = '1f8cfa727a01ac3ae59cb2287db410aaa4e3e3bd9c3141fb3b453a9f51eddb3f'
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
