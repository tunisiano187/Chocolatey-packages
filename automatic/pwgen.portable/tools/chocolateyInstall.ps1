# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.7/PwTech-3.5.7-32bit.zip/download'
$checksum = '837dd3e7c55f51a8dde1bd292698425bf3d7cbf06beb8c20d879466dce06c87a'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.7/PwTech-3.5.7-64bit.zip/download'
$checksum64 = 'ffa833fe4d162b0565e01fec64ba6bbc99d5810e935fb796e4f764be14c3e6ad'

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
