$packageName        = $env:ChocolateyPackageName
$url                = 'https://s3.ap-northeast-2.amazonaws.com/net.xiles.public/download/nexusfile_5.4.1.zip'
$checksum           = 'eec39d8987a681da1cb9a48727167328edc30ea29c6acebb900fafb3e7dd7907'
$checksumType       = 'sha256'
$toolsDir           = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
