$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$url            = 'https://www.nirsoft.net/utils/chromehistoryview.zip'
$checksum       = '2ec1c491db61f9f003ea2d8b9c01773a298ec4f46eb838b2ef277b02d16d9ba7'
$checksumType   = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile    = Join-Path $toolsDir "$($packageName).exe"

$PackageArgs = @{
    PackageName             = $packageName
    Url                     = $url
    UnzipLocation           = $toolsDir
    Checksum                = $checksum
    ChecksumType32          = $checksumType
}

Install-ChocolateyZipPackage @PackageArgs

Set-Content -Path ("$installFile.gui") `
            -Value $null
