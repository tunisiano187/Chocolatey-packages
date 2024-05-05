$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32          = 'https://www.zeusedit.com/agent/bin/asvn32-v276.zip'
$checksum32     = ''
$checksumType   = ''
$url64          = 'https://www.zeusedit.com/agent/bin/asvn32-v276.zip'
$checksum64     = ''

$packageArgs = @{
    packageName     = $packageName
    fileType        = 'EXE'
    softwareName    = "$($packageName)*"
    unzipLocation   = $toolsDir

    checksum        = $checksum32
    checksumType    = $checksumType
    url             = $url32

    checksum64      = $checksum64
    checksumType64  = $checksumType
    url64bit        = $url64

    silentArgs      = '/sp- /silent /norestart /suppressmsgboxes'
    validExitCodes  = @(0)
}

Install-ChocolateyZipPackage @packageArgs
