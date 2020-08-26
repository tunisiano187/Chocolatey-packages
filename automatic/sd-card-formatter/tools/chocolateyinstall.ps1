$ErrorActionPreference     = 'Stop'
$url                       = 'https://www.sdcard.org/downloads/formatter/eula_windows/SDCardFormatterv5_WinEN.zip'
$Checksum                  = '4a3e7018af14681100c17d0e71464113a2f4dd4bc6eaa45b8aeed4ce6c67bfba'
$ChecksumType              = 'sha256'

$packageArgs = @{
    packageName            = "$env:chocolateyPackageName"
    url                    = $url
    checksum               = $Checksum
    checksumType           = $ChecksumType
    UnzipLocation          = Join-path $env:TEMP $env:chocolateyPackageName
}
Install-ChocolateyZipPackage @packageArgs

$url = $(Get-ChildItem -Path $(Join-path $env:TEMP $env:chocolateyPackageName) -Filter *.exe -Recurse).FullName

$packageArgs = @{
    packageName            = $env:chocolateyPackageName
    fileType               = 'EXE'
    url                    = $url
    silentArgs             = '/s /v"/qn /norestart"'
}
Install-ChocolateyPackage @packageArgs
