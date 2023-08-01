# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.1/PwTech-3.5.1-32bit.zip/download'
$checksum = '7a874469c99f77bbc44ae2d61223894f3c5d75368c4d791a60da00e99e4d5418'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.1/PwTech-3.5.1-64bit.zip/download'
$checksum64 = '9184511329ec01125a8a1f818541dde360173433cd69a17ffcfcca81f52eae20'

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
