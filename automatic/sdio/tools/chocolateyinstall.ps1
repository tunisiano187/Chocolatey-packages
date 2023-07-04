$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.glenn.delahoy.com/downloads/sdio/SDIO_1.12.12.753.zip'
$checksum = 'c24c4d805947b473c5f9abf3fa3b2168b1aaf8b282d612d004fd60774da49193'
$checksumtype = 'sha256'

$os=(Get-WMIObject win32_operatingsystem).Version.split('.')
if(([int]$os[0] -le [int]6) -and ([int]$os[1] -le [int]3)) {
    Write-output "Operating system not supported"
    exit 0;
}


$SpecificFolder = 'SDIO_1.12.12.753'

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
