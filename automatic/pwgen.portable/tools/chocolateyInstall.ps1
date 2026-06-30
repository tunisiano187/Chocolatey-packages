# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.6.0/PwTech-3.6.0-portable.zip/download'
$checksum = '14db5a4e7bc2b82f934d0bbced233d879c4cd854b162dba6137af45644f03660'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.6.0/PwTech-3.6.0-portable.zip/download'
$checksum64 = '14db5a4e7bc2b82f934d0bbced233d879c4cd854b162dba6137af45644f03660'

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
