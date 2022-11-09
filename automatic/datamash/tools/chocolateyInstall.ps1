$url32          = 'https://download.savannah.gnu.org/releases/datamash/windows-binaries/datamash-1.3-no-locale-32bit.exe'
$checksum32     = 'ae6ed021819a4cc2481b4b517c25348df4f8ed15c24ba5ff5f2e7fc1b32b69dc'
$checksumType32 = 'sha1'
$url64          = ''
$checksum64     = ''
$checksumType64 = ''
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    unzipLocation   = $toolsDir
    url             = $url32
    checksum        = $checksum32
    checksumType    = $checksumType32
    url64           = $url64
    checksum64      = $checksum64
    checksumType64  = $checksumType64
}

Install-ChocolateyZipPackage @packageArgs
