$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$url = 'https://download.electrum.org/4.7.1/electrum-4.7.1-portable.exe'
$checksum = 'e3bbe71a4c723764ebea4d067537792a829b09f7b9264ecf70401216d36df368'
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
