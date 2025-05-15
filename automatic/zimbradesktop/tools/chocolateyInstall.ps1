$packageName        = 'zimbra-desktop'
$installerType      = 'exe'
$silentArgs         = '/S'
$url                = 'https://files.zimbra.com/downloads/zxui/4.45.0/Zimbra_Desktop_4.45.0_8e5331bdc_20250429110645.exe'
$checksum           = '715a2a5dcb355435c653e1c5df0ec64448f5b6e1ae2203976a867400c8268646'
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
