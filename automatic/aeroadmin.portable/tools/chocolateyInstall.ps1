$packageName    = $env:ChocolateyPackageName
$url            = 'https://ulm.aeroadmin.com/AeroAdmin.exe'
$checksum       = 'ee54577067550559c4711c9e5e10435807f9deee9a5adb4409cb60a6b0108700'
$checksumType   = 'sha256'
$fileFullPath   = "$(split-path -parent $PSCommandPath)\AeroAdmin.exe"

$packageArgs = @{
    packageName     = $packageName
    fileType        = 'EXE'
    url             = $url

    checksum        = $checksum
    checksumType    = $checksumType

    FileFullPath    = $fileFullPath
}

Get-ChocolateyWebFile @packageArgs
