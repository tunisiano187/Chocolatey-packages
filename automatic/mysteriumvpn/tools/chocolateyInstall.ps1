$packageName    = $env:ChocolateyPackageName
$url            = 'https://github.com/mysteriumnetwork/mysterium-vpn-desktop/releases/download/10.11.1/MysteriumVPN-Setup-10.11.1.exe'
$checksum       = 'f1c8e363d6a0323bb51f0dbf8670d1fe200e5b1e1455e2e530b38bd9bf969471'
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
