$ErrorActionPreference = 'Stop'
#$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download01.logi.com/web/ftp/pub/techsupport/options/options_installer.exe'
$checksum       = '8A8882C14F4ABBEF7756A2E58A69E26AF7D2191A26195C51F4325029552C96AE'
$checksumType   = 'sha256'

Confirm-Win10

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    url            = $url
    checkum        = $checksum
    checksumType   = $checksumType
    fileType       = 'EXE'
    silentArgs     = '/quiet /update:false'
    validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
