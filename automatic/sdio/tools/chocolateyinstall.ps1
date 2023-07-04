$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.glenn.delahoy.com/downloads/sdio/SDIO_1.12.13.754.zip'
$checksum = '6a42a93c3dd3061405757b9d51e98bb57674ed3e930619c2a8e6f80c0f41ddb5'
$checksumtype = 'sha256'

$os=(Get-WMIObject win32_operatingsystem).Version.split('.')
if(([int]$os[0] -le [int]6) -and ([int]$os[1] -le [int]3)) {
    Write-output "Operating system not supported"
    exit 0;
}


$SpecificFolder = 'SDIO_1.12.13.754'

$packageArgs = @{
    packageName     = 'sdio'
    unzipLocation   = $toolsDir
    fileType        = 'ZIP'
    SpecificFolder  = $SpecificFolder
    url             = $url
    checksum        = $checksum
    checksumType    = $checksumtype
}

Install-ChocolateyZipPackage @packageArgs
