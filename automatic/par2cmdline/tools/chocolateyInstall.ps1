$url            = 'https://github.com//Parchive/par2cmdline/releases/download/v0.6.13/par2cmdline-0.6.13-x86-win32.zip'
$checksum       = '96a5d354e9eb0908a5c57b3dcfaae299'
$checksumType   = 'md5'
$url64          = 'https://github.com//Parchive/par2cmdline/releases/download/v0.6.13/par2cmdline-0.6.13-x86-win32.zip'
$checksum64     = '96a5d354e9eb0908a5c57b3dcfaae299'
$checksumType64 = 'md5'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'EXE'
    Url           = $url
    Url64bit      = $url64
  
    UnzipLocation = $toolsDir
    checksum      = $Checksum
    checksumType  = $ChecksumType
    checksum64    = $Checksum64
    checksumType64= $ChecksumType64
  
}
  
Install-ChocolateyZipPackage @packageArgs