$ErrorActionPreference = 'Stop'; # stop on all errors
$url                = 'https://stompsoftware.com/downloadfiles/albumstomp/SetupAlbumStompV2.exe'
$checksum           = ''
$checksumType       = ''

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'exe'
    url            = $url

    softwareName   = 'AlbumStomp*'

    checksum       = $checksum
    checksumType   = $checksumType

    # validExitCodes= @(0, 3010, 1641)
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
    validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
