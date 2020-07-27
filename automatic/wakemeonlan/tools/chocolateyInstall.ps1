$packageName = $env:ChocolateyPackageName
$url = '{{DownloadUrl}}'
$checksum = '{{Checksum}}'
$checksumType = 'sha256'
$url64 = ''
$checksum64 = ''
$checksumType64 = '' 
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile = Join-Path $toolsDir "$($packageName).exe"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -Url64 = "$url64" `
                             -CheckSum64 "$checksum64" `
                             -CheckSumType64 "$checksumType64"

Set-Content -Path ("$installFile.gui") `
            -Value $null