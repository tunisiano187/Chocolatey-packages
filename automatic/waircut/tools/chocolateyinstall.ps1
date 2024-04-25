$ErrorActionPreference = 'Stop'

$PackageName    = $env:ChocolateyPackageName
$Url            = 'https://sourceforge.net/projects/freepascal/files/Win32/3.0.4/fpc-3.0.4.i386-win32.exe'
$checksum       = ''
$checksumType   = ''

$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    fileType      = 'ZIP'
    url           = $Url
    checksum      = $checksum
    checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs