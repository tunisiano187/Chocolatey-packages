$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url      = 'https://www.ubackup.com/ss/download/adb/AOMEIBackupperStd.exe'

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    unzipLocation = $toolsDir
    fileType      = 'EXE'
    url           = $url
    softwareName  = 'AOMEI Backupper Standard*'
    checksum      = '4391ab2f786785643ca89a56dc3725f9d91fb7fed11d60334265d0107c4da024'
    checksumType  = 'sha256'
    silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs
