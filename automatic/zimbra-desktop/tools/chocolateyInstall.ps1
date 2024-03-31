$packageName = 'zimbra-desktop'
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$url = 'https://s3.amazonaws.com/files.zimbra.com/downloads/zdesktop/7.3.1/b13063/zdesktop_7_3_1_ga_b13063_20170628044139_win32.msi'
$checksum = '09c4d465a6b90032d649e18646a2484f'
$checksumType = 'sha256'
$validExitCodes = @(0)

$MinimumWindowsVersion = "10.0.0"
if((Get-CimInstance win32_operatingsystem).Version -lt $MinimumWindowsVersion) {
    Write-Error "Windows 10 or higher required"
}

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
