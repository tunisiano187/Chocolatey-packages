# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.4/PwTech-3.5.4-32bit.zip/download'
$checksum = '3f9ce1e90f228bf441eabb48d4519dfb8271e8e350b52e2a49cb1fddbf2e3fa9'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.4/PwTech-3.5.4-64bit.zip/download'
$checksum64 = 'd42d9ad7f347dbabbca56d2d264de653d9448d029eb18a53d69fd7fed3315094'

# static vars
$checksumType = 'sha256'
$checksumType64 = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# $Env:ChocolateyInstall\helpers\functions
$packageArgs = @{
    PackageName     = $packageName
    UnzipLocation   = $toolsDir
    Url             = $url
    Checksum        = $checksum
    ChecksumType    = $checksumType
    Url64bit        = $url64
    Checksum64      = $checksum64
    ChecksumType64  = $checksumType64
}

Install-ChocolateyZipPackage @packageArgs

# create empty sidecar so shimgen creates shim for GUI rather than console
$installFile = Join-Path -Path $toolsDir `
                         -ChildPath "$($packageName).exe.gui"
Set-Content -Path $installFile `
            -Value $null
