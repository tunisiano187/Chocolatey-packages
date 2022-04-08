$packageName    = $env:ChocolateyPackageName
$url            = 'https://github.com/mysteriumnetwork/mysterium-vpn-desktop/releases/download/10.9.0/MysteriumVPN-Setup-10.9.0.exe'
$checksum       = '00d15abaa65bc4dd79cd1ad94354d3bee1be2e841a514cfd2fbcf5d09340b88e'
$checksumType   = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    fileType      = 'EXE'
    url           = $url

    softwareName  = 'mysterium*'

    checksum      = $checksum
    checksumType  = $checksumType

    silentArgs   = '/S' # NSIS
    validExitCodes= @(0)
  }

  Install-ChocolateyPackage @packageArgs
