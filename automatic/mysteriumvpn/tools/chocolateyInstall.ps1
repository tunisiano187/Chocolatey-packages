$packageName    = $env:ChocolateyPackageName
$url            = 'https://github.com/mysteriumnetwork/mysterium-vpn-desktop/releases/download/10.5.3/MysteriumVPN-Setup-10.5.3.exe'
$checksum       = 'a71a88dc700e1e374afe1abaf3a45e3c3cb11203d6f9ae7e79ac96bc737d3ca0'
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
