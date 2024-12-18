$ErrorActionPreference     = 'Stop'
$url                       = 'https://www.sdcard.org/downloads/formatter/eula_windows/SD%20Card%20Formatter%20Setup.exe'
$Checksum                  = '0243f9adae333f8a158d8137c29a64f411a0c3dc7827715d49483235852db091'
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
