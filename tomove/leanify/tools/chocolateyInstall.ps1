$url            = 'https://github.com/JayXon/Leanify/releases/download/v0.4.3/Leanify_win32.7z'
$checksum       = 'cf6d3af3c123ae1e3e7385d025e2b4d90e79a7bdac6cdea95876b2e476d313f7'
$checksumType   = 'sha256'
$url64          = 'https://github.com/JayXon/Leanify/releases/download/v0.4.3/Leanify_win64.7z'
$checksum64     = 'e6d0552e5d3fceb7d603cc2b2fae65c7e4f5cfb9915882842363699f3245d744'
$checksumType64 = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    unzipLocation   = $toolsDir

    url             = $url
    checksum        = $checksum
    checksumType    = $checksumType

    Url64bit        = $url64
    Checksum64      = $checksum64
    ChecksumType64  = $checksumType64

}

Install-ChocolateyZipPackage @packageArgs
