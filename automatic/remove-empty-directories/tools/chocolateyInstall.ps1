$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$url = 'https://vorboss.dl.sourceforge.net/project/rem-empty-dir/red-v2.2-setup.exe'
$checksum = '8f163a667304e6d86c306cab637b6f344afdb166fb4ed66190cf10fcbb1b91d3'
$checksumType = 'sha256'

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -Url "$url" `
                          -UnzipLocation "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)" `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
