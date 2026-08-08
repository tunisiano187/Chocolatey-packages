$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://download.todesktop.com/25020447d4kq915/Perplexity%20AI%20Setup%201.7.0-x64.exe'
  checksum64     = 'DA39F74BEA4996934A7CD34513905BB230ED65FB1257C15EC804A4C88A94F34B'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
