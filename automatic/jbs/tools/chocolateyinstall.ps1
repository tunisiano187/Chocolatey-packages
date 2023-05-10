$ErrorActionPreference = 'Stop'
$packageName= $env:ChocolateyPackageName
$installerType      = 'EXE'
$silentArgs = '/S'
$url        = 'https://dl.johnsadventures.com/SwitcherSetup551.exe'
$checksum   = '145931027a1d2aa13d711780452dc35d659c2b25753bbf528e66483cee5b002d'
$checksumtype = 'sha256'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url -checksum $checksum -ValidExitCodes @(0,1223) -checksumType $checksumtype
