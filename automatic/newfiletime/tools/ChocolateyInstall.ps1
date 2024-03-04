$ErrorActionPreference = 'Stop'

$PackageName = 'newfiletime'
$Url32 = 'https://www.softwareok.com/Download/NewFileTime.zip'
$Checksum32 = '@{Algorithm=SHA256; Hash=DC90D88E4189D073B8CB05E76D899F11D41F636E1137821E333DCAC392D0B835; Path=C:\Users\appveyor\AppData\Local\Temp\1\chocolatey\NewFileTime\NewFileTime.zip}'
$ChecksumType32 = 'sha256'
$Url64 = 'https://www.softwareok.com/Download/NewFileTime_x64.zip'
$Checksum64 = '@{Algorithm=SHA256; Hash=1518DD3C7D39BDD75E551C373484966F520C20D8F5BEFD5469F070AF9EEBFB83; Path=C:\Users\appveyor\AppData\Local\Temp\1\chocolatey\NewFileTime\NewFileTime.zip}'
$ChecksumType64 = 'sha256'
$UrlExtra = 'https://www.softwareok.com/Download/NewFileTime_Unicode.zip'
$ChecksumExtra = '@{Algorithm=SHA256; Hash=0E7F0F66CA43A7A83478468AAA4FF17206C15820B4234AA5AE68FE6A4AA8DFD2; Path=C:\Users\appveyor\AppData\Local\Temp\1\chocolatey\NewFileTime\NewFileTime.zip}'
$ChecksumTypeExtra = 'sha256'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName    = $PackageName
    Url32          = $Url32
    Checksum32     = $Checksum32
    ChecksumType32 = $ChecksumType32
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $UrlExtra
    Checksum       = $ChecksumExtra
    ChecksumType   = $ChecksumTypeExtra
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
