$ErrorActionPreference = 'Stop';
$url            = 'https://appdownload.deepl.com/windows/full/DeepLSetup.exe'
$checksum       = '7efe1647a730b35eb70900857b25df98f30948e79857f291f4d860cae0bd7b73'
$checksumtype   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName

  url           = $url
  checksum      = $checksum
  checksumType  = $checksumtype

  silentArgs     = '/s'
}

Install-ChocolateyPackage @packageArgs
