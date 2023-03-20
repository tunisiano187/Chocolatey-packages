$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bcpierce00/unison/releases/download/v2.53.1/unison-v2.53.1%2Bocaml-4.14.0%2Bmingw64c%2Bx86_64.windows.zip'
$checksum       = 'e19d501f8e5168289efe59c859af7c51f3f460f579caecc0f097fc0ea17dd740'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
