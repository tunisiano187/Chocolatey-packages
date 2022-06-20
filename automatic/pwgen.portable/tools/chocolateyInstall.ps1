# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.4.3/PwTech-3.4.3-32bit.zip/download'
$checksum = '59a2a9047cd7e57906410ad81349b004832fcd73f2b277c5f85daf4265c69164'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.4.3/PwTech-3.4.3-64bit.zip/download'
$checksum64 = 'a439e66dc3a9ba2b1c17bb2c9b174deb90d01ba6b5b1fdfe6140254d01228fa2'

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
