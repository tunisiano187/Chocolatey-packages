$packageName  = $env:ChocolateyPackageName
$url          = 'https://download.sysinternals.com/files/Handle.zip'
$checksum     = '1f2e6eda07f0581c1cfac733f34005c9122c4d2a9d5e0b6d99797502a76ad79e'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
Write-Verbose "Accepting license..."
$regRoot = 'HKCU:\Software\Sysinternals'
$regPkg = 'Handle'
$regPath = Join-Path $regRoot $regPkg
if (!(Test-Path $regRoot)) {New-Item -Path "$regRoot"}
if (!(Test-Path $regPath)) {New-Item -Path "$regRoot" -Name "$regPkg"}
Set-ItemProperty -Path "$regPath" -Name EulaAccepted -Value 1
if ((Get-ItemProperty -Path "$regPath").EulaAccepted -ne 1) {
  throw "Failed setting registry value."
}