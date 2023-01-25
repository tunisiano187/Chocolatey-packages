$url            = 'https://github.com/Parchive/par2cmdline/releases/download/v0.8.1/par2cmdline-0.8.1-win-x86.zip'
$checksum       = 'f86935e1b322ebc19394c2f570f6908eb5682d1234cfe7da4d415430694c8f32'
$checksumType   = 'sha256'
$url64          = 'https://github.com/Parchive/par2cmdline/releases/download/v0.8.1/par2cmdline-0.8.1-win-x64.zip'
$checksum64     = '4df82b5cfc0071020ac2318db857e403c7a2ab932b7ee78028a8c1ddb0d7c547'
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
