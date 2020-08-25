$ErrorActionPreference     = 'Stop'
$url                       = ''
$Checksum                  = ''
$ChecksumType              = ''

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