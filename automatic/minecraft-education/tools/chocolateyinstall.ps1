$ErrorActionPreference = 'Stop';


$packageName      = $env:ChocolateyPackageName
$url              = 'https://aka.ms/downloadmee-desktopApp'
$checksum         = 'b37a8626b644f4497f29c468de5ccdc08d8c006c903ae7c18ad24d63b737837c'
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
