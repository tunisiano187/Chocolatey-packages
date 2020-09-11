$ErrorActionPreference = 'Stop'
$packageName = '{{PackageName}}'
$url = 'https://download.electrum.org/4.0.3/electrum-4.0.3-portable.exe'
$checksum = '32b1c2b15df99fd5dc3d7fdc10b41404d213779ce9ae21ba766e691b5a6c95b9'
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
