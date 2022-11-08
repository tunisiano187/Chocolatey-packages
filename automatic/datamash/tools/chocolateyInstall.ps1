$url32          = 'http://files.housegordon.org/datamash/bin/datamash-1.0.6-windows.zip'
$checksum32     = '6874c749945acb84ac0fd9b759f382a7fe64dd7b'
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