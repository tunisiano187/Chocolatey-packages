$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$url = 'https://download.electrum.org/4.4.4/electrum-4.4.4-portable.exe'
$checksum = '4f6523fe061a700e2c624995db3619ded8e3f013d3bb74f3f7081b341f03ee59'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile = Join-Path $toolsDir "electrum.exe"
try {
  Get-ChocolateyWebFile -PackageName "$packageName" `
                        -FileFullPath "$installFile" `
                        -Url "$url" `
                        -Checksum "$checksum" `
                        -ChecksumType "$checksumType"
  # create an empty sidecar metadata file for closed-source shimgen.exe to prevent blank black window
  Set-Content -Path ("$installFile.gui") `
              -Value $null
} catch {
  throw $_.Exception
}
