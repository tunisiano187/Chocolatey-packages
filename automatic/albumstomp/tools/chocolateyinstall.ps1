$ErrorActionPreference = 'Stop'; # stop on all errors
$url                = 'https://stompsoftware.com/downloadfiles/albumstomp/SetupAlbumStompV2.exe'
$checksum           = 'e5ab0c75a6595c25a9ee9e6f8cc70ee07747d936f18f82fe82c8016ebb57071a'
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
