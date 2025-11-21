$packageName        = 'zimbra-desktop'
$installerType      = 'exe'
$silentArgs         = '/S'
$url                = 'https://files.zimbra.com/downloads/zxui/4.47.0/Zimbra_Desktop_4.47.0_6e7bef6e4_20251030104002.exe'
$checksum           = '8a12f618eb039c9725c55881625f89d401f6065ad1a0c24127574bd0c78cac0d'
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
