$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32          = 'https://www.zeusedit.com/agent/bin/asvn32-v276.zip'
$checksum32     = 'cd3e8f366c7b247dc310dd67413028004c1d4e5b71557451460ed37241b561b6'
$checksumType   = 'sha256'
$url64          = 'https://www.zeusedit.com/agent/bin/asvn64-v276.zip'
$checksum64     = 'f8cfd51389d8f479b3461156776c11e8420bcd5cf731a4711ab66370ccd8aab6'

$packageArgs = @{
    packageName     = $packageName
    unzipLocation   = $toolsDir

    checksum        = $checksum32
    checksumType    = $checksumType
    url             = $url32

    checksum64      = $checksum64
    checksumType64  = $checksumType
    url64bit        = $url64
}

Install-ChocolateyZipPackage @packageArgs

$File = (Get-ChildItem -Path $toolsDir -Filter "*.exe").FullName

$packageArgs = @{
    packageName     = $packageName
    fileType        = 'EXE'
    softwareName    = "$($packageName)*"

    file            = $File

    silentArgs      = '/sp- /silent /norestart /suppressmsgboxes'
    validExitCodes  = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
