# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.0/PwTech-3.5.0-32bit.zip/download'
$checksum = '6cb009ec746e59777642c3cfe928fbbffd02bc3539068bbb50d1a9f133e0536a'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.0/PwTech-3.5.0-64bit.zip/download'
$checksum64 = 'afa0d685166ccaf483e38d5621990852c3aba3406d6623e339362fe958ea7fce'

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
