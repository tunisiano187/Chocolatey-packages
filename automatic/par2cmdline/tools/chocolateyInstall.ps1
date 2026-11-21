$url            = 'https://github.com/Parchive/par2cmdline/releases/download/v2.0.0/par2cmdline-2.0.0-win-x64.zip'
$checksum       = '0c366b0e3348ad48b93562361c53966b6717b7d9655e35849e9c506f1eaa9ae4'
$checksumType   = 'sha256'
$url64          = 'https://github.com/Parchive/par2cmdline/releases/download/v2.0.0/par2cmdline-2.0.0-win-x64.zip'
$checksum64     = '0c366b0e3348ad48b93562361c53966b6717b7d9655e35849e9c506f1eaa9ae4'
$checksumType64 = 'sha256'
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
