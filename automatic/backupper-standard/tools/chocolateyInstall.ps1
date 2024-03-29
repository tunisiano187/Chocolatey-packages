$ErrorActionPreference = 'Stop'
$toolsDir           = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                = 'https://www.ubackup.com/ss/download/adb/AOMEIBackupperStd.exe'
$checksum           = ''
$checksumtype       = ''

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    unzipLocation   = $toolsDir
    fileType        = 'EXE'
    url             = $url
    softwareName    = 'AOMEI Backupper Standard*'
    checksum        = $checksum
    checksumType    = $checksumtype
    silentArgs      = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs
