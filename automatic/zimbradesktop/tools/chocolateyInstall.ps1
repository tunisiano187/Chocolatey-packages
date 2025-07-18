$packageName        = 'zimbra-desktop'
$installerType      = 'exe'
$silentArgs         = '/S'
$url                = 'https://files.zimbra.com/downloads/zxui/4.46.0/Zimbra_Desktop_4.46.0_c975480bb_20250701133104.exe'
$checksum           = 'd34e29afc8173049c86736825436313ba2c1d3dea1b6c6a619eefcb55b8422d4'
$checksumType       = 'sha256'
$validExitCodes     = @(0)

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
