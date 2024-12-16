$ErrorActionPreference     = 'Stop'
$url                       = 'https://www.sdcard.org/downloads/formatter/eula_windows/SDCardFormatterv5_WinEN.zip'
$Checksum                  = 'df18843616643f53a613fd536eb4ff05a068de16b2902f48234706a2cfedc374'
$ChecksumType              = 'sha256'

$packageArgs = @{
    packageName            = "$env:chocolateyPackageName"
    url                    = $url
    checksum               = $Checksum
    checksumType           = $ChecksumType
    fileType               = 'EXE'
    silentArgs             = '/s /v"/qn /norestart"'
}

Install-ChocolateyPackage @packageArgs
