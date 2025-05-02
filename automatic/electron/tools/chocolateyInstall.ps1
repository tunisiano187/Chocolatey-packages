$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v36.1.0/electron-v36.1.0-win32-ia32.zip'
$checksum = '664345f040adac69118ebbddf64a79583edf58de6ea01fc3fcacbc7410583a35'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v36.1.0/electron-v36.1.0-win32-x64.zip'
$checksum64 = 'ab533cb9343a7029a01f46b90bc57b3018b94bd94ed1683144aa2b1bd3e962d9'
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
