$ErrorActionPreference = 'Stop';


$packageName      = $env:ChocolateyPackageName
$url              = 'https://aka.ms/downloadmee-desktopApp'
$checksum         = '8da0d6937677402dd8f59acb5f6c161d4cc5e215f06eb723700188d68eacef7e'
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
