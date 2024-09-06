$ErrorActionPreference = 'Stop'; # stop on all errors
$url                = 'https://stompsoftware.com/downloadfiles/albumstomp/SetupAlbumStompV2.exe'
$checksum           = 'e6da1083635df601b5eb841de879a2286efef0982bc4d9c3183f4f2126fd0a9c'
$checksumType       = 'sha256'

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
