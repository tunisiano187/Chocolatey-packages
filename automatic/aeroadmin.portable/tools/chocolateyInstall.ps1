$packageName    = $env:ChocolateyPackageName
$url            = 'http://www.aeroadmin.com/AeroAdmin_v3.0b.exe'
$checksum       = ''
$checksumType   = ''
$fileFullPath = "$(split-path -parent $PSCommandPath)\AeroAdmin.exe"

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    fileType        = 'EXE'
    url             = $url

    checksum        = $checksum
    checksumType    = $checksumType

    FileFullPath    = $fileFullPath
}

Get-ChocolateyWebFile @packageArgs