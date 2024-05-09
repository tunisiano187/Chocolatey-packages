$ErrorActionPreference = 'Stop'
$packageName= $env:ChocolateyPackageName
$installerType      = 'EXE'
$silentArgs = '/S'
$url        = 'https://dl.johnsadventures.com/SwitcherSetup58.exe'
$checksum   = 'b412edcdfb873329a894a7950e9330002f774e5c6d512244d7bc564503063e68'
$checksumtype = 'sha256'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url -checksum $checksum -ValidExitCodes @(0,1223) -checksumType $checksumtype
