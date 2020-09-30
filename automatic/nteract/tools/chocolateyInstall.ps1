$ErrorActionPreference = 'Stop';

$packageName= 'nteract'
$url        = 'https://github.com/nteract/nteract/releases/download/v0.15.0/nteract-setup-0.15.0.exe'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'nteract*'

  checksum      = '6b070c19f91e74c33a2678dd842e891aff19c10f9d36cf4dbec25810ed4cee41'
  checksumType  = 'sha256'

  silentArgs   = '/S' # NSIS
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

# Install ipykernel to get started directly
# try {
#   Start-ChocolateyProcessAsAdmin "&python -m pip install ipykernel"
#   Start-ChocolateyProcessAsAdmin "&python -m ipykernel install --user"    
# } catch {}
