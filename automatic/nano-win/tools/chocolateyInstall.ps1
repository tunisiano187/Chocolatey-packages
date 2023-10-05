$url            = 'https://github.com/okibcn/nano-for-windows/releases/download/v7.2-22.1/nano-for-windows_win32_v7.2-22.1.zip'
$checksum       = '0ac8fa4fc97f5b9eaf16d5b561c4b5df5d923deb29d5a8f21265e58dfaf2513d'
$checksumType   = 'sha256'
$url64          = 'https://github.com/okibcn/nano-for-windows/releases/download/v7.2-22.1/nano-for-windows_win64_v7.2-22.1.zip'
$checksum64     = 'ce50a799a5fae37ac36ff2d7f3680968ca4af11a808edad96bcce746c13ccd20'
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
