$packageName    = $env:ChocolateyPackageName
$url            = 'https://jztkft.dl.sourceforge.net/project/megui/megui-stable/2913/MeGUI-2913-32.zip'
$checksum       = '9ec40f5342593626e1ed5e945ca6fc94499f68dda3ba3775b9fc850a19e13f88'
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
