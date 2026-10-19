# generated vars
$packageName = 'pwgen.portable'
$url = 'https://downloads.sourceforge.net/project/pwgen-win/Password%20Tech/3.6.1/PwTech-3.6.1-portable.zip'
$checksum = 'C4BBDEB697D66E8FF2FCF268235F254B406D10B9163DD53230FE8D640DB1C686'
$url64 = 'https://downloads.sourceforge.net/project/pwgen-win/Password%20Tech/3.6.1/PwTech-3.6.1-portable.zip'
$checksum64 = 'C4BBDEB697D66E8FF2FCF268235F254B406D10B9163DD53230FE8D640DB1C686'

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
