# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.4.2/PwTech-3.4.2-32bit.zip/download'
$checksum = '30d63f5c539bbec627835d5323cbb7bde694904393e44979b81bebefcadd6d1c'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.4.2/PwTech-3.4.2-64bit.zip/download'
$checksum64 = 'ca0685ddaf6c0176317dd8f5d752554dba2d28c0d2a6390442dab204d7e95810'

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
