$packageName    = $env:ChocolateyPackageName
$url            = 'https://sourceforge.net/projects/megui/files/megui-stable/2896/MeGUI-2896-32.zip/download'
$checksum       = 'ff54154d9d7d9da354517f6ee89de051a07239cf1964935f3fea9e73590c85d2'
$checksumType   = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile    = Join-Path $toolsDir "$($packageName).exe"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

# create empty sidecar so shimgen creates shim for GUI rather than console
Set-Content -Path "$installFile.gui" `
            -Value $null