$ErrorActionPreference = 'Stop';


$packageName      = $env:ChocolateyPackageName
$url              = 'https://aka.ms/downloadmee-desktopApp'
$checksum         = '1f0c700d3435360845487a9a662bd9dfe6c4399fe920cc204f0b0361ef9d6cfb'
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
