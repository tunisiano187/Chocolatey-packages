$packageName    = $env:ChocolateyPackageName
$url            = 'https://github.com/mysteriumnetwork/mysterium-vpn-desktop/releases/download/10.8.0/MysteriumVPN-Setup-10.8.0.exe'
$checksum       = '39aa7787ca1f45880cde1863a534a9fa72fd46e3a869e18f4c418524f28b23f0'
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
