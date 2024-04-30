$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = 'agentsvn'
$url32          = 'http://www.zeusedit.com/agent/bin/asvn-v256.exe'
$checksum32     = ''
$checksumType   = ''
$url64          = 'http://www.zeusedit.com/agent/bin/asvn-v256.exe'
$checksum64     = ''

$packageArgs = @{
    packageName     = $packageName
    fileType        = 'EXE'
    softwareName    = "$($packageName)*"

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
