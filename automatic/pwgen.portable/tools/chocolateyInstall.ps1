# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.2/PwTech-3.5.2-32bit.zip/download'
$checksum = 'bb66e225649dac4264bab9691a5750818ab84bbfb84d23802af1851348d3a280'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.5.2/PwTech-3.5.2-64bit.zip/download'
$checksum64 = '09c081fc2f754436068e09cc6034b1d2279a01eaf06e87834156f65edc2d9059'

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
