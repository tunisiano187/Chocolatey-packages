# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.3.0/PwTech-3.3.0-32bit.zip/download'
$checksum = '73bad18c69398d4236979e5202fe5ac99791cb075a15a205aee6803ea7c5cbf5'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.3.0/PwTech-3.3.0-64bit.zip/download'
$checksum64 = '057e45198155b22cbd7a824f87ca423211cba1d9b0ad29afb54b257fdc0bdf9f'

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
