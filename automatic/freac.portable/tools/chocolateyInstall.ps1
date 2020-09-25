$packageName    = 'freac.portable'
$packageVersion = '1.0.28'
$url            = 'https://sourceforge.net/projects/bonkenc/files/freac/1.0.28/freac-1.0.28-bin.zip/download'
$checksum       = '6fa3c031cef72aa1ac5407ee13db5816236f7404cc3fd43ce39c580a9f181964'
$checksumType   = 'sha256'

$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


Install-ChocolateyZipPackage -PackageName "$packageName" -UnzipLocation "$toolsDir" -Url "$url" -Checksum "$checksum" -ChecksumType "$checksumType"

Rename-Item "$toolsDir\freac-$packageVersion-bin" "$toolsDir\bin"

$files = get-childitem "$toolsDir" -include *.exe -exclude freac*.exe -recurse
foreach ($file in $files) {
  New-Item "$file.ignore" -type file -force | Out-Null
}
