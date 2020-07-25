$packageName = '{{PackageName}}'
$url = 'https://www.nirsoft.net/utils/pinginfoview.zip'
$checksum = '9c074b15ff6d0bbf74f668a51907581f85eabec7cbaec42e4a03454719a95f45'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile = Join-Path $toolsDir "$($packageName).exe"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

Set-Content -Path ("$installFile.gui") `
            -Value $null
