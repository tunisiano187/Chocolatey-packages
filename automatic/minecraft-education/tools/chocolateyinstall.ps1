$ErrorActionPreference = 'Stop';


$packageName      = $env:ChocolateyPackageName
$url              = 'https://launcher.mojang.com/download/MinecraftInstaller.msi'
$checksum         = ''
$checksumType     = ''

$packageArgs = @{
  packageName     = $packageName
  fileType        = 'msi'
  url             = $url

  silentArgs      = "/qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes  = @(0, 3010, 1641, 1622)

  softwareName    = "$packageName*"
  checksum        = $checksum
  checksumType    = $checksumType
}

Install-ChocolateyPackage @packageArgs

















