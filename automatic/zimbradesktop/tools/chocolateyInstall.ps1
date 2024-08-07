$packageName        = 'zimbra-desktop'
$installerType      = 'exe'
$silentArgs         = '/S'
$url                = 'https://files.zimbra.com/downloads/zxui/4.38.0/Zimbra_Desktop_4.38.0_a405fbbdb_20240605192212.exe'
$checksum           = '6926588e8e12ff2e37f07f35db8beb9ab6c574ed550993a99e758e8a22514b21'
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
