$ErrorActionPreference = 'Stop'
$packageName= $env:ChocolateyPackageName
$installerType      = 'EXE'
$silentArgs = '/S'
$url        = 'https://dl.johnsadventures.com/SwitcherSetup54.exe'
$checksum   = '8f819e316091c11cc6150cb72a234058007ec22928dcd57b5635a4e3e055cc38'
$checksumtype = 'sha256'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url -checksum $checksum -ValidExitCodes @(0,1223) -checksumType $checksumtype
