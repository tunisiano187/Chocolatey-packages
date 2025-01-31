# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.6/PwTech-3.5.6-32bit.zip/download'
$checksum = '9831dd7fb307c5f46624330a380aac1925ee3a498bdc921c4baefd89ca078391'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.6/PwTech-3.5.6-64bit.zip/download'
$checksum64 = 'ba06c657e70691e06a3d4e89e2ce8ec75cd3d8983fa0b10aa1aea2c7dca32c34'

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
