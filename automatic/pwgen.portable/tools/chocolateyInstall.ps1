# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.3/PwTech-3.5.3-32bit.zip/download'
$checksum = '9dcd5fa1f6321d8744f339c20cdd7f2cd6aee0950fd0c32a272d0f784475acc9'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.3/PwTech-3.5.3-64bit.zip/download'
$checksum64 = 'ec0d454985d0e033d107ec76d92589b419f40b0697e8eac06454560c502a804c'

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
