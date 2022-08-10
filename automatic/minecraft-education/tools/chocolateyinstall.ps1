$ErrorActionPreference = 'Stop';


$packageName      = $env:ChocolateyPackageName
$url              = 'https://aka.ms/downloadmee-desktopApp'
$checksum         = '44d4b2dfc6b4a25f2dcc9534998ea4b2a61bd28847342350cdbb34ee6c194510'
$checksumType     = 'sha256'

$packageArgs = @{
  packageName     = $packageName
  fileType        = 'exe'
  url             = $url

  silentArgs      = "/qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes  = @(0, 1603, 3010, 1641, 1622)

  softwareName    = "$packageName*"
  checksum        = $checksum
  checksumType    = $checksumType
}

  Install-ChocolateyPackage @packageArgs
