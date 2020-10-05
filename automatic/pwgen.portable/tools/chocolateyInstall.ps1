# generated vars
$packageName = 'pwgen.portable'
$url = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.2.0/PwTech-3.2.0-32bit.zip/download'
$checksum = '8607147b7b38263b39560b81bd83bcf02b5ddf26eaeb7d9b2a056c0cbc26640d'
$url64 = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/3.2.0/PwTech-3.2.0-64bit.zip/download'
$checksum64 = '8607147b7b38263b39560b81bd83bcf02b5ddf26eaeb7d9b2a056c0cbc26640d'

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
