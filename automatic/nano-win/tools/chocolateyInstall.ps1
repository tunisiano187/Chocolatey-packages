$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/mysteriumnetwork/mysterium-vpn-desktop/releases/download/10.14.4/MysteriumVPN-Setup-10.14.4.exe'
$checksum       = 'd97c0ba16c5371fa9c1844bccb0cf2ec59f34f9d9d3667525bbfcdbdb4044b12'
$checksumtype   = 'sha256'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    checksum      = $checksum
    checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
