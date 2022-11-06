# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.4.4/PwTech-3.4.4-32bit.zip/download'
$checksum = '6d2c1c3cf5817676682c69c4424266c631deb2b34d94a3b54dcb461b77b76741'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.4.4/PwTech-3.4.4-64bit.zip/download'
$checksum64 = 'b09b53c4810f1447e0dcc1927b278a783f14878f4f4027f5cdb1387bf42f0ff7'

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
