$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://sourceforge.net/projects/gwyddion/files/gwyddion/2.71/Gwyddion-2.71.win32.exe/download'
$checksum       = 'DE0D6185930B8B64A5550E9CCBFB70F40E60B043B5A59475D5CF6FFC5BFFE4EA4603685EA96CB9BFCD89299EC7A4C5BEB6A6BCF9DC2B83364578CFE5FC8EAD91'
$checksumType   = 'SHA512'
$url64          = 'https://sourceforge.net/projects/gwyddion/files/gwyddion/2.71/Gwyddion-2.71.win64.exe/download'
$checksum64     = '0488D5BAD96683CDEABBAAABD0FC9FE8B0263B2A3FCCF5A47ED485FE6171949A3A9F429C67D38A12D281E366F39F4F3F70A57A14D18F5375BC89BB508F73D730'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  checksum       = $checksum
  checksumType   = $checksumType
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = $checksumType
  validExitCodes = @(0)
  silentArgs     = '/S'
  softwareName   = 'Gwyddion'
}

Install-ChocolateyPackage @packageArgs

#Remove-Item $toolsDir\*.exe -EA SilentlyContinue | Out-Null

# UPDATE INSTRUCTIONS
# Replace EXE files
