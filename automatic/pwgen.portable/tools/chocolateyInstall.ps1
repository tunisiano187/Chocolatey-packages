# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.4.5/PwTech-3.4.5-32bit.zip/download'
$checksum = '6e0c8fa831382a5c16799d9b9458fcad0fec79d9362f6a515058942f7d03d10f'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.4.5/PwTech-3.4.5-64bit.zip/download'
$checksum64 = '6d07d43585809216963b18fdb1466c9ea1e8844ae25353c36ae48b602e4dbdf8'

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
