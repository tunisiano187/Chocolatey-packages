$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$url = 'https://download.electrum.org/4.8.0/electrum-4.8.0-portable.exe'
$checksum = '2558ce74b04f261088b7a4bb03a5cc16dd30c70288c7d32313d861bcc6b9df86'
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
