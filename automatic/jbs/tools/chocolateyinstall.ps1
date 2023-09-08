$ErrorActionPreference = 'Stop'
$packageName= $env:ChocolateyPackageName
$installerType      = 'EXE'
$silentArgs = '/S'
$url        = 'https://dl.johnsadventures.com/SwitcherSetup551.exe'
$checksum   = 'eb9286d48f13833becec9d67dff61d6686dad00e3ee1da398b6636147737ebd5'
$checksumtype = 'sha256'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url -checksum $checksum -ValidExitCodes @(0,1223) -checksumType $checksumtype
