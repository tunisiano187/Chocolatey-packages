$ErrorActionPreference = 'Stop'
$packageName= $env:ChocolateyPackageName
$installerType      = 'EXE'
$silentArgs = '/S'
$url        = 'https://dl.johnsadventures.com/SwitcherSetup53.exe'
$checksum   = '435919a59346d063929f740c10f61aee4d110a5aefb5624e303bd16877a0a1cd'
$checksumtype = 'sha256'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url -checksum $checksum -ValidExitCodes @(0,1223) -checksumType $checksumtype
