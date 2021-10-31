# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.4.1/PwTech-3.4.1-32bit.zip/download'
$checksum = 'c1ac202f869583511aecb60915fe0bb04e3a7e22f5128e6c73dab7e5dcf56d2c'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.4.1/PwTech-3.4.1-64bit.zip/download'
$checksum64 = '6fb08c527b9574611af5baa64115fc40fcc835a0fca8220999ddbe88b4b0b87a'

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
