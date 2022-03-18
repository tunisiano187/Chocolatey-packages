$ErrorActionPreference     = 'Stop'
$url                       = 'https://www.sdcard.org/downloads/formatter/eula_windows/SDCardFormatterv5_WinEN.zip'
$Checksum                  = 'df18843616643f53a613fd536eb4ff05a068de16b2902f48234706a2cfedc374'
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
