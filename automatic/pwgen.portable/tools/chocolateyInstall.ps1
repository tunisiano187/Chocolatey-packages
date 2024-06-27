# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.5/PwTech-3.5.5-32bit.zip/download'
$checksum = '17168b439e8719813848cc6b7f545f2bfe58ed21fda6b6bf16ae28564c02ad62'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.5/PwTech-3.5.5-64bit.zip/download'
$checksum64 = 'bbe26c44980fcd21a090a62aa193cb896c202ce3b71b77a42a06227e4b690c9d'

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
