# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.4.0/PwTech-3.4.0-32bit.zip/download'
$checksum = '5982e73b275185a482689b8b82a92bd06f26b95d2da06a6d1098aa83577751a9'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.4.0/PwTech-3.4.0-64bit.zip/download'
$checksum64 = '69b36feeccc3a037f0fb2ddbb2d33f9555c842150f20a045853a55cf80c6ec5a'

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
