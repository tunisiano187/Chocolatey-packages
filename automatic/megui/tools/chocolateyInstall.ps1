$url            = 'https://master.dl.sourceforge.net/project/megui/megui-stable/2944/MeGUI-2944-32.7z'
$checksum       = '011331a4751b3c3028401b9e92d256cbbcc05169b9c4059165617856a8bb2df3'
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
