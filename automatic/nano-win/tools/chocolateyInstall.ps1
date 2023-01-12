$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://files.lhmouse.com/nano-win/nano-win_10156_v7.1-13-ga4fc06579.7z'
$checksum       = 'cacc06d4f97c49f13a06c6281f29b4e76eaf820f5081a78b26acf9d1c647d603'
$checksumtype   = 'sha256'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    checksum      = $checksum
    checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
