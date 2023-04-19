$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$url = 'https://download.electrum.org/4.4.0/electrum-4.4.0-portable.exe'
$checksum = '881482a34eb19eba8a3719705616ca5e90304fd9ebe5f1bb9c03738055a93795'
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
