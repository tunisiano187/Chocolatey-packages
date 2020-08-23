$packageName = 'argyll'
$url = 'http://argyllcms.com/Argyll_V2.0.1_win32_exe.zip'
$checksum = 'eaecb48ef903b378c6bb41e6c295a6e3387023c5474fa89ab379aec06f5ca12c'
$checksumType = 'sha256'
$url64 = 'http://argyllcms.com/Argyll_V2.0.1_win64_exe.zip'
$checksum64 = 'd1831767365a6cfe67d3f59c79d07acea86cdde1552e83d47467c39334458fbc'
$checksumType64 = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Url64bit "$url64" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -Checksum64 "$checksum64" `
                             -ChecksumType64 "$checksumType64"