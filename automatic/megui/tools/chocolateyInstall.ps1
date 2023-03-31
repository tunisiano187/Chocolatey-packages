$url            = 'https://master.dl.sourceforge.net/project/megui/megui-stable/2933/MeGUI-2933-32.zip'
$checksum       = 'ff3968adb53bed0da6084e5c7e9e972a7361fa4a204f728e51c28acf3d7cc5ea'
$checksumType   = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile    = Join-Path $toolsDir "$($packageName).exe"

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    UnzipLocation   = $toolsDir
    softwareName    = "$env:ChocolateyPackageName*"

    url             = $url
    checksum        = $checksum
    checksumType    = $checksumType
  }

Install-ChocolateyZipPackage @packageArgs

# create empty sidecar so shimgen creates shim for GUI rather than console
Set-Content -Path "$installFile.gui" `
            -Value $null
