$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://stompsoftware.com/downloadfiles/albumstomp/SetupAlbumStompV2.exe'

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $toolsDir
    fileType       = 'exe'
    url            = $url

    softwareName   = 'AlbumStomp*'

    checksum       = '2E7DB665D7D4061BF6D32D4A43FFA61139536F2FECA358539F56B73894573989'
    checksumType   = 'sha256' #default is md5, can also be sha1, sha256 or sha512

    # validExitCodes= @(0, 3010, 1641)
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
    validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
