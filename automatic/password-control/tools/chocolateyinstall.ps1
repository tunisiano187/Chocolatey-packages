$ErrorActionPreference = 'Stop'
$packageName    = 'password-control' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.wisesoft.co.uk/download/passwordcontrolv2.4.exe'
$checksum       = 'C68339FA54C646D23ABF11F8648874F2948A1A5C6E486257CBDE725834284FF9'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0)
$fileLocation   = "$toolsDir\Setup.msi"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Password Control'   
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$env:ChocolateyInstall\lib\$packageName\tools\Setup.msi" | out-null
Remove-Item "$env:ChocolateyInstall\lib\$packageName\tools\Setup.exe" | out-null