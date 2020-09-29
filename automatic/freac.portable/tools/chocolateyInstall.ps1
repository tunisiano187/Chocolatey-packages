$ErrorActionPreference = 'Stop';
$packageName= 'Software Ideas Modeler.portable'
$toolsDir =  "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    PackageName    = $packageName
    Url64          = 'https://github.com/enzo1982/freac/releases/download/v1.1.2/freac-1.1.2b-windows-x64.zip'
    Checksum64     = '6B0363CE216DF714E243DD4780C96357C4D95A4CF79F167DF287DB041C393DB3'
    ChecksumType64 = 'sha256'
    UnzipLocation  = $toolsDir
}

# Download and unzip into a temp folder
Install-ChocolateyZipPackage @packageArgs