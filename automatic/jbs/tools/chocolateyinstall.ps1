$packageName= $env:ChocolateyPackageName
$installerType      = 'EXE'
$silentArgs = '/S'
$url        = 'https://dl.johnsadventures.com/SwitcherSetup52.exe'
$checksum   = '790BD6562A70F9D9002BBB3F1F11D7D0'
$checksumtype = 'sha256'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url -checksum $checksum -ValidExitCodes @(0,1223) -checksumType $checksumtype
