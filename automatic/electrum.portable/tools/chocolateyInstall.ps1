$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$url = 'https://download.electrum.org/4.8.1/electrum-4.8.1-portable.exe'
$checksum = '52d2e89d502338e6daeb868be976df60fd6087fb2e7e55634c1ac390d0e191c9'
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
