$packageName    = $env:ChocolateyPackageName
$url            = 'https://annystudio.com/jcpicker.zip'
$checksum       = 'a8242605238dd16adfdff4fb0ca2b8a79072b147b109ad5dfed7e7ef6f0f503b'
$checksumType   = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile    = Join-Path $toolsDir "$($packageName)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Url64bit "" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

Set-Content -Path ("$installFile.gui") `
            -Value $null
