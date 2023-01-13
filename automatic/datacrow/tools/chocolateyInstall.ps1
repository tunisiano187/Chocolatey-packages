$packageName = 'datacrow'
$installerType = 'exe'
$silentArgs = ''
$url = 'https://sourceforge.net/projects/datacrow/files/datacrow_4.4_windows_installer.zip/download'
$checksum = 'c3e459bf3beffd91f45561dea6e7bb0e1d10c196c6f8f5f19b1200be20157e64'
$checksumType = 'sha256'
$validExitCodes = @(0)

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$silentArgs32 = "$toolsDir\chocolateyInstall32.xml"
$silentArgs64 = "$toolsDir\chocolateyInstall64.xml"

$tempDir = Join-Path $env:Temp "$packageName"
if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir) | Out-Null}
$tempDir = Join-Path $tempDir $env:packageVersion
if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir) | Out-Null}
$zipFile = Join-Path $tempDir 'datacrow_windows_installer.zip'
$installFile = "$tempDir\install.exe"

Get-ChocolateyWebFile -PackageName "$packageName" `
                      -FileFullPath "$zipFile" `
                      -Url "$url" `
                      -Checksum "$checksum" `
                      -ChecksumType "$checksumType"

Get-ChocolateyUnzip -FileFullPath "$zipFile" `
                    -Destination "$tempDir" `
                    -PackageName "$packageName"

if ((Get-ProcessorBits 64) -and ($env:chocolateyForceX86)) {
  $silentArgs = $silentArgs32
}
if ((Get-ProcessorBits 64) -and (-not($env:chocolateyForceX86))) {
  $silentArgs = $silentArgs64
}
if (-not(Get-ProcessorBits 64)) {
  $silentArgs = $silentArgs64
}

Start-ChocolateyProcessAsAdmin -Statements "/c `"$installFile`" $silentArgs" `
                               -ExeToRun "cmd.exe"
